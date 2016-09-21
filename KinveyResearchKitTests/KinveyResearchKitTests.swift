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
        Client.sharedClient.initialize(appKey:"kid_SJFDiXDn", appSecret: "feacdd13aca0451ebc9edd58fb8304c7")
        Client.sharedClient.logNetworkEnabled = true
        
        
        if let user = Client.sharedClient.activeUser {
            print ("logged in as", user)
        } else {
            
            weak var expectationLogin = expectation(description: "login")
            
            User.login(username: "test", password: "test") { (user, error) in
                print ("new user logged in", user)
                expectationLogin?.fulfill()
            }
            
            waitForExpectations(timeout: 30, handler: { error in
                expectationLogin = nil
            })
        }
        

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Client.sharedClient.activeUser?.logout()
        super.tearDown()
    }
    
    func testSaveTaskResult() {
        
        weak var expectationSave = expectation(description: "save")
        
        let taskResultStore = DataStore<TaskResult>.collection(.network)
        
        let taskId = "example"
        let uuid = UUID()
        let outputDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let result = ORKTaskResult(taskIdentifier: taskId, taskRun: uuid, outputDirectory: outputDir)
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
        
        waitForExpectations(timeout: 30) { error in
            expectationSave = nil
        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
