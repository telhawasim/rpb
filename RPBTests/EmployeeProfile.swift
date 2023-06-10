//
//  EmployeeProfile.swift
//  RPBTests
//
//  Created by Synavos on 31/03/2023.
//

import XCTest
@testable import RPB

final class EmployeeProfile: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchEmployeeListing() {
        var data: EmployeeListingResponse?

        let bodyParams = [ParameterKeys.limit: "\(5)"]
        let expectation = XCTestExpectation(description: "API response received")

        UserService.shared.fetchEmployeeListing(params: bodyParams ) { status in
            switch status {
            case .success(let userResponse):
                data = userResponse
                print("Success")
            case .failure(let error):
                XCTFail("API error: \(error.localizedDescription)")
            }
            expectation.fulfill()
            XCTAssertTrue((data != nil))
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
