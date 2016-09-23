//
//  Factory.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit

func build(_ result: ORKResult) -> Result? {
    if let stepResult = result as? ORKStepResult {
        return StepResult(stepResult: stepResult)
    } else if let taskResult = result as? ORKTaskResult {
        return TaskResult(taskResult: taskResult)
    }
    return nil
}

func build(_ array: [ORKResult]?) -> [Result]? {
    var results: [Result]? = nil
    if let array = array {
        results = [Result]()
        for result in array {
            if let result = build(result) {
                results?.append(result)
            }
        }
    }
    return results
}
