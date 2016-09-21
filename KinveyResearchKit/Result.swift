//
//  KNVTask.swift
//  KinveyResearchKit
//
//  Created by Tejas on 8/25/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

class Result: Entity {
    
    dynamic var identifier: String?
    dynamic var endDate: Date?
    dynamic var startDate: Date?
    var saveAble: Bool?
    
    internal convenience init(result: ORKResult){
        self.init()
        
        identifier = result.identifier
        endDate = result.endDate
        startDate = result.startDate
        saveAble = result.isSaveable
    }
    
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        identifier <- map [PersistableIdKey]
        startDate <- map ["startDate"]
        endDate <- map ["endDate"]
        saveAble <- map ["saveAble"]
    }
    
}

class TaskResult: Result {
    dynamic var taskRunUUID: String?
    dynamic var outputDirectory: String?
    
    convenience init (taskResult: ORKTaskResult) {
        self.init(result: taskResult)
        
        taskRunUUID = taskResult.taskRunUUID.uuidString
        outputDirectory = taskResult.outputDirectory?.absoluteString
    }
    
    override class func collectionName() -> String {
        return "TaskResult"
    }
    
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        taskRunUUID <- map ["taskRunUUID"]
        outputDirectory <- map ["outputDirectory"]
    }
    
}

//class StepResult: Result {
//    
//    convenience init (stepResult: ORKStepResult) {
//        self.init(result: stepResult)
//    }
//    
//    override class func collectionName() -> String {
//        return "StepResult"
//    }
//    
//    override func propertyMapping(map: Map) {
//        super.propertyMapping(map)
//        
//    }
//    
//}
