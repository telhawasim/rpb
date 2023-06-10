//
//  CreateProfileTestCase.swift
//  RPBTests
//
//  Created by Synavos on 04/04/2023.
//

import XCTest
@testable import RPB

final class CreateProfileTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateAPIResponse() {
        let expectation = XCTestExpectation(description: "API response received")
        
        let bodyParams = [ParameterKeys.profileName: "IOS", ParameterKeys.employeeId: "642ea381d9657e6bf9ae6513"]
        
        UserService.shared.addProfile(body: bodyParams, onComplete: { response in
            switch response {
            case .success(let userResponse):
                XCTAssertNotNil(userResponse)
            case .failure(let error):
                XCTFail("API call failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
