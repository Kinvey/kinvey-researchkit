//
//  ScaleQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class ScaleQuestionResult: QuestionResult {
    
    dynamic var scaleAnswer: NSNumber?
    
    convenience init(scaleQuestionResult: ORKScaleQuestionResult) {
        self.init(questionResult: scaleQuestionResult)
        
        scaleAnswer = scaleQuestionResult.scaleAnswer
    }
    
    override open class func collectionName() -> String {
        return "ScaleQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        scaleAnswer <- map["scaleAnswer"]
    }
    
}
