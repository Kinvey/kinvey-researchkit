//
//  KinveySignupStepViewController.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveySignupStepViewController: ORKWaitStepViewController {
    
    var signupStep: KinveySignupStep {
        return step as! KinveySignupStep
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let registrationStepResult = signupStep.registrationStepResult
        
        var email: String? = nil
        var password: String? = nil
        var givenName: String? = nil
        var familyName: String? = nil
        var gender: String? = nil
        var dateOfBirth: Date? = nil
        
        if let results = registrationStepResult?.results {
            for result in results {
                switch result.identifier {
                case "ORKRegistrationFormItemEmail":
                    email = (result as? ORKTextQuestionResult)?.textAnswer
                case "ORKRegistrationFormItemPassword":
                    password = (result as? ORKTextQuestionResult)?.textAnswer
                case "ORKRegistrationFormItemGivenName":
                    givenName = (result as? ORKTextQuestionResult)?.textAnswer
                case "ORKRegistrationFormItemFamilyName":
                    familyName = (result as? ORKTextQuestionResult)?.textAnswer
                case "ORKRegistrationFormItemGender":
                    gender = (result as? ORKChoiceQuestionResult)?.choiceAnswers?.first as? String
                case "ORKRegistrationFormItemDOB":
                    dateOfBirth = (result as? ORKDateQuestionResult)?.dateAnswer
                default:
                    break
                }
            }
        }
        
        User.signup(username: email!, password: password!, client: signupStep.client) { user, error in
            if let user = user as? KinveyResearchKit.User {
                user.email = email
                user.givenName = givenName
                user.familyName = familyName
                user.gender = gender
                user.dateOfBirth = dateOfBirth
                user.save(client: self.signupStep.client) { user, error in
                    self.goForward()
                }
            } else {
                self.goBackward()
            }
        }
    }
    
}
