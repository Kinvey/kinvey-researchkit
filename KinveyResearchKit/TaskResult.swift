//
//  TaskResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

class TaskResult: CollectionResult {
    
    dynamic var taskRunUUID: String?
    dynamic var outputDirectory: String?
    
    convenience init(taskResult: ORKTaskResult) {
        self.init(collectionResult: taskResult)
        
        taskRunUUID = taskResult.taskRunUUID.uuidString
        outputDirectory = taskResult.outputDirectory?.absoluteString
    }
    
    override class func collectionName() -> String {
        return "TaskResult"
    }
    
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        taskRunUUID <- map["taskRunUUID"]
        outputDirectory <- map["outputDirectory"]
    }
    
}
