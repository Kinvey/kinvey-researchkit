//
//  StepResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

class StepResult: CollectionResult {

    convenience init(stepResult: ORKStepResult) {
        self.init(collectionResult: stepResult)
    }

    override class func collectionName() -> String {
        return "StepResult"
    }

    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
    }

}
