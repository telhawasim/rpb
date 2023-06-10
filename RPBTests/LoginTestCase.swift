//
//  LoginTestCase.swift
//  RPBTests
//
//  Created by Telha Wasim on 28/02/2023.
//

import XCTest
@testable import RPB

class LoginTestCase: XCTestCase {
    var loginBinder: LoginBinder!
    var lblDescription: UILabel!
    var lblLogin: UILabel!
    var lblEmail: UILabel!
    var lblPassword: UILabel!
    var txtEmail: UITextField!
    var txtPassword: UITextField!
    var btnLogin: UIButton!
    var btnShowPassword: UIButton!
    
    override func setUp() {
        super.setUp()
        lblDescription = UILabel()
        lblLogin = UILabel()
        lblEmail = UILabel()
        lblPassword = UILabel()
        txtEmail = UITextField()
        txtPassword = UITextField()
        btnLogin = UIButton()
        btnShowPassword = UIButton()
        loginBinder = LoginBinder(lblDescription: lblDescription, lblLogin: lblLogin, lblEmail: lblEmail, lblPassword: lblPassword, txtEmail: txtEmail, txtPassword: txtPassword, btnLogin: btnLogin, btnShowPassword: btnShowPassword)
    }
    
    func test_For_TextField_Validation() {
        //Given
        txtEmail.text = "admin@synavos.com"
        txtPassword.text = "123323"

        //When
        let result = loginBinder.validation()

        //Then
        XCTAssertTrue(result)
        print(result)
    }
    
    func testLogInAPIResponse() {
        let expectation = XCTestExpectation(description: "API response received")
        
        let bodyParams = [ParameterKeys.email: "admin@synavos.com", ParameterKeys.password: "admin@synavos"]
        
        UserService.shared.signIn(body: bodyParams, onComplete: { response in
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
}
