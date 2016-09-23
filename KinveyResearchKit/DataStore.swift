//
//  DataStore.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-23.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import PromiseKit

class PromiseRequest<T>: Request {
    
    var executing: Bool {
        get {
            return promise.isResolved
        }
    }
    
    /// Indicates if a request was cancelled or not.
    var cancelled = false
    
    /// Cancels a request in progress.
    func cancel() {
        cancelled = true
    }
    
    /// Report upload progress of the request
    var progress: ((Kinvey.ProgressStatus) -> Swift.Void)?
    
    let promise: Promise<T>
    
    init(promise: Promise<T>) {
        self.promise = promise
    }
    
}

public extension DataStore where T: TaskResult {
    
    @discardableResult
    public func save(_ persistable: ORKTaskResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        let taskResult = TaskResult(taskResult: persistable)
        return save(taskResult as! T, writePolicy: writePolicy, completionHandler: completionHandler)
    }
    
}

public extension DataStore where T: StepResult {
    
    @discardableResult
    public func save(_ persistable: ORKStepResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        var promises = [Promise<Result>]()
        if let results = persistable.results {
            for result in results {
                if let taskResult = result as? ORKTaskResult {
                    let promise = Promise<Result> { fulfill, reject in
                        DataStore<TaskResult>.collection(type, deltaSet: true, client: client).save(taskResult) { taskResult, error in
                            if let taskResult = taskResult {
                                fulfill(taskResult)
                            } else if let error = error {
                                reject(error)
                            } else {
                                reject(Kinvey.Error.invalidResponse)
                            }
                        }
                    }
                    promises.append(promise)
                }
            }
        }
        let promise = when(fulfilled: promises).then { results -> Promise<StepResult?> in
            let stepResult = StepResult(stepResult: persistable)
            return Promise<StepResult?> { fulfill, reject in
                self.save(stepResult as! T, writePolicy: writePolicy) { stepResult, error in
                    fulfill(stepResult)
                    completionHandler?(stepResult, error)
                }
            }
        }
        return PromiseRequest(promise: promise)
    }
    
}
