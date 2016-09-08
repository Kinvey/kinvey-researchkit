//
//  KinveyResearchKitTests.swift
//  KinveyResearchKitTests
//
//  Created by Tejas on 8/25/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import XCTest
import Kinvey
import ResearchKit

@testable import KinveyResearchKit

class KinveyResearchKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Client.sharedClient.initialize(appKey:"kid_S1Bd9cy9", appSecret: "5b1770f12e8c4563ad9fc4cc502e7f04")
        Client.sharedClient.logNetworkEnabled = true
        
        
        if let user = Client.sharedClient.activeUser {
            print ("logged in as", user)
        } else {
            
            weak var expectationLogin = expectationWithDescription("login")
            
            User.login(username: "test", password: "test") { (user, error) in
                print ("new user logged in", user)
                expectationLogin?.fulfill()
            }
            
            waitForExpectationsWithTimeout(30, handler: { error in
                expectationLogin = nil
            })
        }
        

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Client.sharedClient.activeUser?.logout()
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        weak var expectationSave = expectationWithDescription("save")
        
        let taskResultStore = DataStore<TaskResult>.collection(.Network)
        
        let taskId = "foo"
        let uuid = NSUUID()
        let outputDir =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let result = ORKTaskResult(taskIdentifier: taskId, taskRunUUID: uuid, outputDirectory: outputDir)
        taskResultStore.save(TaskResult(taskResult: result)) { (kResult, error) in
            if (kResult != nil) {
                print("success saving")
                print(kResult)
            } else {
                print("error saving")
                print(error)
            }
            
            expectationSave?.fulfill()
        }
        
        waitForExpectationsWithTimeout(30) { error in
            expectationSave = nil
        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
