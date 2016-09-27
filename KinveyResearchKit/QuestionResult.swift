//
//  QuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-26.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

public enum QuestionType: Int {
    
    case none, scale, singleChoice, multipleChoice, decimal, integer, boolean, text, timeOfDay, dateAndTime, date, timeInterval, location
    
    var stringValue: String {
        switch self {
            case .none:
                return "None"
            case .scale:
                return "Scale"
            case .singleChoice:
                return "SingleChoice"
            case .multipleChoice:
                return "MultipleChoice"
            case .decimal:
                return "Decimal"
            case .integer:
                return "Integer"
            case .boolean:
                return "Boolean"
            case .text:
                return "Text"
            case .timeOfDay:
                return "TimeOfDay"
            case .dateAndTime:
                return "DateAndTime"
            case .date:
                return "Date"
            case .timeInterval:
                return "TimeInterval"
            case .location:
                return "Location"
        }
    }
    
    static func build(_ questionType: ORKQuestionType) -> QuestionType {
        switch questionType {
            case .none:
                return QuestionType.none
            case .scale:
                return QuestionType.scale
            case .singleChoice:
                return QuestionType.singleChoice
            case .multipleChoice:
                return QuestionType.multipleChoice
            case .decimal:
                return QuestionType.decimal
            case .integer:
                return QuestionType.integer
            case .boolean:
                return QuestionType.boolean
            case .text:
                return QuestionType.text
            case .timeOfDay:
                return QuestionType.timeOfDay
            case .dateAndTime:
                return QuestionType.dateAndTime
            case .date:
                return QuestionType.date
            case .timeInterval:
                return QuestionType.timeInterval
            case .location:
                return QuestionType.location
        }
    }
    
    static func build(_ questionType: String) -> QuestionType? {
        switch questionType {
            case "None":
                return QuestionType.none
            case "Scale":
                return QuestionType.scale
            case "SingleChoice":
                return QuestionType.singleChoice
            case "MultipleChoice":
                return QuestionType.multipleChoice
            case "Decimal":
                return QuestionType.decimal
            case "Integer":
                return QuestionType.integer
            case "Boolean":
                return QuestionType.boolean
            case "Text":
                return QuestionType.text
            case "TimeOfDay":
                return QuestionType.timeOfDay
            case "DateAndTime":
                return QuestionType.dateAndTime
            case "Date":
                return QuestionType.date
            case "TimeInterval":
                return QuestionType.timeInterval
            case "Location":
                return QuestionType.location
            default:
                return nil
        }
    }
    
}

class QuestionTypeTransformer: TransformType {
    
    typealias Object = QuestionType
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? String {
            return QuestionType.build(value)
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value.stringValue
        }
        return nil
    }
    
}

open class QuestionResult: Result {
    
    private dynamic var _questionType: Int = QuestionType.none.rawValue
    var questionType: QuestionType {
        get {
            return QuestionType(rawValue: _questionType)!
        }
        set {
            _questionType = newValue.rawValue
        }
    }
    
    convenience init(questionResult: ORKQuestionResult) {
        self.init(result: questionResult)
        
        questionType = QuestionType.build(questionResult.questionType)
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        questionType <- (map["questionType"], QuestionTypeTransformer())
    }
    
}
