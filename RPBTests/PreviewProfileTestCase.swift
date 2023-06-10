//
//  PreviewProfileTestCase.swift
//  RPBTests
//
//  Created by Synavos on 03/04/2023.
//

import XCTest
@testable import RPB

final class PreviewProfileTestCase: XCTestCase {
    var profileID: String?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchProfileDetail() {
        var profile: ResumeResponse?
        
        let expectation = XCTestExpectation(description: "API response received")

        UserService.shared.fetchProfileDetail(id: "642ea3a1d9657e6bf9ae6539") { status in
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
