//
//  CollectionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

struct KinveyRef: Mappable {
    
    var collection: String
    var _id: String
    
    public init(collection: String, _id: String) {
        self.collection = collection
        self._id = _id
    }
    
    public init?(map: Map) {
        guard
            let collection = map["collection"].currentValue as? String,
            let _id = map["_id"].currentValue as? String
        else {
            return nil
        }
        
        self.collection = collection
        self._id = _id
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        collection <- map["collection"]
        _id <- map["_id"]
    }
    
}

let StepResultCollectionName = StepResult.collectionName()
let TaskResultCollectionName = TaskResult.collectionName()

class ResultTransformer<T: Result>: TransformType {
    
    typealias Object = T
    typealias JSON = [String : Any]
    
    func transformToJSON(_ value: T?) -> [String : Any]? {
        if let value = value, let identifier = value.identifier {
            return KinveyRef(collection: T.collectionName(), _id: identifier).toJSON()
        }
        return nil
    }
    
    func transformFromJSON(_ value: Any?) -> T? {
        if let kinveyRef = value as? KinveyRef {
            switch kinveyRef.collection {
            case StepResultCollectionName:
                break
            case TaskResultCollectionName:
                break
            default:
                break
            }
        }
        return nil
    }
    
}

class ResultArrayTransformer: TransformType {
    
    typealias Object = [Result]
    typealias JSON = [[String : Any]]
    
    func transformFromJSON(_ value: Any?) -> Array<Result>? {
        return nil
    }
    
    func transformToJSON(_ value: Array<Result>?) -> [[String : Any]]? {
        if let value = value {
            var results = [[String : Any]]()
            for result in value {
                if let taskResult = result as? TaskResult {
                    if let kinveyRef = ResultTransformer<TaskResult>().transformToJSON(taskResult) {
                        results.append(kinveyRef)
                    }
                }
            }
            return results
        }
        return nil
    }
    
}

open class CollectionResult: Result {
    
    dynamic var results: [Result]?
    
    var firstResult: Result? {
        get { return results?.first }
    }
    
    internal convenience init(collectionResult: ORKCollectionResult) {
        self.init(result: collectionResult)
        
        results = build(collectionResult.results)
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        results <- (map["results"], ResultArrayTransformer())
    }
    
}
