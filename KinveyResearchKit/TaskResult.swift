//
//  TaskResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class TaskResult: CollectionResult {
    
    dynamic var taskRunUUID: String?
    dynamic var outputDirectory: String?
    
    convenience init(taskResult: ORKTaskResult) {
        self.init(collectionResult: taskResult)
        
        taskRunUUID = taskResult.taskRunUUID.uuidString
        outputDirectory = taskResult.outputDirectory?.absoluteString
    }
    
    override open class func collectionName() -> String {
        return "TaskResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        taskRunUUID <- map[PersistableIdKey]
        outputDirectory <- map["outputDirectory"]
    }
    
}
