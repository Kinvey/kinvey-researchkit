//
//  NumericQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-26.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class NumericQuestionResult: QuestionResult {
    
    dynamic var numericAnswer: NSNumber?
    dynamic var unit: String?
    
    convenience init(numericQuestionResult: ORKNumericQuestionResult) {
        self.init(questionResult: numericQuestionResult)
        
        numericAnswer = numericQuestionResult.numericAnswer
        unit = numericQuestionResult.unit
    }
    
    override open class func collectionName() -> String {
        return "NumericQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        numericAnswer <- map["numericAnswer"]
        unit <- map["unit"]
    }
    
}
