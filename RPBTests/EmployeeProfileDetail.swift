//
//  EmployeeProfileDetail.swift
//  RPBTests
//
//  Created by Synavos on 03/04/2023.
//

import XCTest
@testable import RPB

final class EmployeeProfileDetail: XCTestCase {

    var employeeId: String?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchEmployeeDetail() {
        var model: EmployeeDetail?
        
        let expectation = XCTestExpectation(description: "API response received")

        UserService.shared.fetchEmployeeDetail(id: employeeId ?? "") { status in
            switch status {
            case .success(let userResponse):
                model = userResponse
                print("Success")
            case .failure(let error):
                XCTFail("API error: \(error.localizedDescription)")
            }
            expectation.fulfill()
            XCTAssertTrue((model != nil))
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchEmployeeListing() {
        var data: ProfileListingResponse?
        let bodyParams = [ParameterKeys.employeeId: "642a8399a849bb8e2c66bf16"]
        
        let expectation = XCTestExpectation(description: "API response received")

        UserService.shared.fetchProfileListing(params: bodyParams ) { status in
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
    
//    func testDeleteProfileListing() {
//
//        let expectation = XCTestExpectation(description: "API response received")
//
//        UserService.shared.deleteProfile(id: "642a9cf60bda849aebee752d") { status in
//            switch status {
//            case .success(_):
//                print("Sucessfully Delete Profile")
//            case .failure(_):
//                XCTFail("API error")
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 5.0)
//    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
