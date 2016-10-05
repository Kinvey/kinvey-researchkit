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
    } else if let numericQuestionResult = result as? ORKNumericQuestionResult {
        return NumericQuestionResult(numericQuestionResult: numericQuestionResult)
    } else if let timeIntervalQuestionResult = result as? ORKTimeIntervalQuestionResult {
        return TimeIntervalQuestionResult(timeIntervalQuestionResult: timeIntervalQuestionResult)
    } else if let booleanQuestionResult = result as? ORKBooleanQuestionResult {
        return BooleanQuestionResult(booleanQuestionResult: booleanQuestionResult)
    } else if let dateQuestionResult = result as? ORKDateQuestionResult {
        return DateQuestionResult(dateQuestionResult: dateQuestionResult)
    } else if let choiceQuestionResult = result as? ORKChoiceQuestionResult {
        return ChoiceQuestionResult(choiceQuestionResult: choiceQuestionResult)
    } else if let locationQuestionResult = result as? ORKLocationQuestionResult {
        return LocationQuestionResult(locationQuestionResult: locationQuestionResult)
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
