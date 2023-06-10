//
//  AddEmployeeTestCase.swift
//  RPBTests
//
//  Created by Synavos on 03/04/2023.
//

import XCTest
@testable import RPB

final class AddEmployeeTestCase: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testaddEmployee() {
        var profile: EmployeeResponse?
        
        let bodyParams = [ParameterKeys.name: "Telha",
                          ParameterKeys.designatipn: "642a8399a849bb8e2c66bf16",
                          ParameterKeys.department: "642a82cda849bb8e2c66bf11",
                          ParameterKeys.dateOfBirth: "1999-08-07",
                          ParameterKeys.email: "telhaandnoman@synavos.com",
                          ParameterKeys.phone: "+923350438764",
                          ParameterKeys.dateOfJoining: "2022-05-09",
                          ParameterKeys.profilePicture: "https://poc.synavos.com/uploads/82f8449d-c289-4be4-8e6b-33748dbaa17f.jpg",
        ]
        
        let expectation = XCTestExpectation(description: "API response received")
        UserService.shared.addEmployee(body: bodyParams) { status in
            switch status {
            case .success(let userResponse):
                profile = userResponse
                print("Success")
            case .failure(let error):
                XCTFail("API error: \(error.localizedDescription)")
            }
            expectation.fulfill()
            XCTAssertTrue((profile != nil))
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
