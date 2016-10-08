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
    
    var taskResult: ORKTaskResult {
        get {
            let taskId = "TaskResult_ID"
            let uuid = UUID()
            let outputDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let taskResult = ORKTaskResult(taskIdentifier: taskId, taskRun: uuid, outputDirectory: outputDir)
            return taskResult
        }
    }
    
    var stepResult: ORKStepResult {
        get {
            let stepId = "StepResult_ID"
            let stepResult = ORKStepResult(stepIdentifier: stepId, results: [taskResult])
            return stepResult
        }
    }
    
    lazy var taskResultStore = DataStore<TaskResult>.collection(.network)
    lazy var stepResultStore = DataStore<StepResult>.collection(.network)
    
    func testTaskResult() {
        do { //save
            weak var expectationSave = expectation(description: "Save")
            
            taskResultStore.save(taskResult) { (result, error) in
                XCTAssertNotNil(result)
                XCTAssertNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationSave?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationSave = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            taskResultStore.find(taskResult.identifier) { (result, error) in
                XCTAssertNotNil(result)
                XCTAssertNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
        
        do { //delete
            weak var expectationFind = expectation(description: "Find")
            
            taskResultStore.removeById(taskResult.identifier) { (count, error) in
                XCTAssertNotNil(count)
                XCTAssertNil(error)
                
                if let count = count {
                    XCTAssertEqual(count, 1)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            taskResultStore.find(taskResult.identifier) { (result, error) in
                XCTAssertNil(result)
                XCTAssertNotNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
    }
    
    func testStepResult() {
        do { //save
            weak var expectationSave = expectation(description: "Save")
            
            stepResultStore.save(stepResult) { (result, error) in
                XCTAssertNotNil(result)
                XCTAssertNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.stepResult.identifier)
                    
                    XCTAssertEqual(result.firstResult?.identifier, self.taskResult.identifier)
                }
                
                expectationSave?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationSave = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            taskResultStore.find(taskResult.identifier) { (result, error) in
                XCTAssertNotNil(result)
                XCTAssertNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            stepResultStore.find(stepResult.identifier) { (result, error) in
                XCTAssertNotNil(result)
                XCTAssertNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.stepResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
        
        do { //delete
            weak var expectationRemove = expectation(description: "Remove")
            
            stepResultStore.removeById(stepResult.identifier) { (count, error) in
                XCTAssertNotNil(count)
                XCTAssertNil(error)
                
                if let count = count {
                    XCTAssertEqual(count, 1)
                }
                
                expectationRemove?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationRemove = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            taskResultStore.find(taskResult.identifier) { (result, error) in
                XCTAssertNil(result)
                XCTAssertNotNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
        
        do { //find
            weak var expectationFind = expectation(description: "Find")
            
            stepResultStore.find(stepResult.identifier) { (result, error) in
                XCTAssertNil(result)
                XCTAssertNotNil(error)
                
                if let result = result {
                    XCTAssertEqual(result.identifier, self.taskResult.identifier)
                }
                
                expectationFind?.fulfill()
            }
            
            waitForExpectations(timeout: 30) { error in
                expectationFind = nil
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
