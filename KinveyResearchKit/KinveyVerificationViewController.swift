//
//  File.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-11-01.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveyVerificationViewController : ORKVerificationStepViewController {
    
    private var verificationStep: KinveyVerificationStep {
        return step as! KinveyVerificationStep
    }
    
    override open func resendEmailButtonTapped() {
        if let user = verificationStep.client.activeUser {
            user.sendEmailConfirmation(verificationStep.client) { error in
                if let completionHandler = self.verificationStep.completionHandler {
                    completionHandler(self, error)
                } else if error == nil {
                    self.goForward()
                }
            }
        }
    }
    
}
