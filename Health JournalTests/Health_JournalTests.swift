//
//  Health_JournalTests.swift
//  Health JournalTests
//
//  Created by Sadrac Tijerina on 8/26/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import XCTest
@testable import Health_Journal
import Alamofire

class Health_JournalTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("-----–TEST-----\n")
        let networkManager = NetworkManager()
        
        networkManager.fetchTasks(){
            data in
            print("RUNNINGs")
//                guard let data = data, error == nil else {
//
//                    print("ERROR------------->", error ?? "Unknown error in Network")
//                    return
//                }
                print("DATA: ------> ", data)
        }
        print("\n-----END-----")
    }

    
    
    func testCall() throws{
        print("-----–TEST-----\n")
        let urlString = "http://localhost:5000/tasks"
        let url = URL(string: urlString)!
        
        typealias ServiceResponse = (([String: Any?]?, Error?)) -> Void
        print("ABOUT TO REQUESt")
        AF.request(urlString).response {
            response in
            debugPrint(response)
        }
        

        print("\n-----END-----")
    }
    
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
