//
//  AddResumeDetail.swift
//  RPBTests
//
//  Created by Synavos on 04/04/2023.
//

import XCTest
@testable import RPB

final class AddResumeDetail: XCTestCase {
    
    var resume: ResumeModel?
    var experiences: [Experience]?
    var skills: [SkillsResponse]?
    var certificates: [CertificatesResponse]?
    var academics: [AcademicsResponse]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testaddEmployee() {
        
        let bodyParams = [
            ParameterKeys.basicInfo: [ParameterKeys.companyName: "Noman Akram",
                                      ParameterKeys.designation: "642a8399a849bb8e2c66bf16",
                                      ParameterKeys.email: "nomanakram404@gmail.com",
                                      ParameterKeys.phone: "+923200614086",
                                      ParameterKeys.gitLink: "https://www.git.com",
                                      ParameterKeys.linkedLink: "https://www.linkdin.com",
                                      ParameterKeys.basicInfoSummary: "Hi My Name is Norman Akram I am IOS Developer Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industrys standard dummy text ever since the when an unknown printer took a galley of type and scrambled it to make a type specimen book"],
            ParameterKeys.experiences: experiences ?? [],
            ParameterKeys.skills: skills ?? [],
            ParameterKeys.certificates: certificates ?? [],
            ParameterKeys.academics: academics ?? []
        ] as [String: Any]
        
        let expectation = XCTestExpectation(description: "API response received")
        UserService.shared.updateProfile(id: "642ea3a1d9657e6bf9ae6539", body: bodyParams) { status in
            switch status {
            case .success(let userResponse):
                self.resume = userResponse
                print("Success")
            case .failure(let error):
                XCTFail("API error: \(error.localizedDescription)")
            }
            expectation.fulfill()
            XCTAssertTrue((self.resume != nil))
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
