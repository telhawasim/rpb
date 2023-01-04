//
//  RPBUITests.swift
//  RPBUITests
//
//  Created by Bilal Nisar on 20/12/2022.
//

import XCTest

final class RPBUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        loginScreenUITest(app: app)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func loginScreenUITest(app: XCUIApplication) {
        let title = app.staticTexts["Log In"]
        XCTAssertTrue(title.exists)
        
        let description = app.staticTexts["Welcome back. Log in to continue."]
        XCTAssertTrue(description.exists)
        
        let email = app.staticTexts["Email"]
        XCTAssertTrue(email.exists)
        
        let password = app.staticTexts["Password"]
        XCTAssertTrue(password.exists)
        
        let btnShowPassword = app.buttons["hide password"]
        XCTAssertTrue(btnShowPassword.exists)
        
        let btnLogin = app.buttons["Log In"]
        XCTAssertTrue(btnLogin.exists)

        let txtEmail = app.textFields["abc@gmail.com"]
        XCTAssertTrue(txtEmail.exists)

        let txtPassword = app.secureTextFields["12345678"]
        XCTAssertTrue(txtPassword.exists)
        
        txtEmail.tap()
        txtEmail.typeText("rpb@admin.com")
        
        txtPassword.tap()
        txtPassword.typeText("12345678")
        
        btnShowPassword.tap()
        
        btnLogin.tap()
        homeScreenUITest(app: app)
    }
    
    func homeScreenUITest(app: XCUIApplication) {
        let title = app.staticTexts["Hello"]
        XCTAssertTrue(title.exists)
        
        let employeeTotal = app.staticTexts["Total Employees"]
        XCTAssertTrue(employeeTotal.exists)
        
        let employeeNumber = app.staticTexts["100"]
        XCTAssertTrue(employeeNumber.exists)
    
        let btnAddEmployee = app.buttons["AddEmployee"]
        XCTAssertTrue(btnAddEmployee.exists)
        btnAddEmployee.tap()
        
        app.buttons["cross 20x20"].tap()
        app.buttons["Yes"].tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["iOS Developer"].tap()
        
        let btnArrowLeft = app.buttons["arrow left"]
        XCTAssertTrue(btnArrowLeft.exists)
        
        btnArrowLeft.tap()
        
        let btnHome = app.buttons["Home"]
        let btnEmployees = app.buttons["Employee"]
        let btnSetting = app.buttons["TabbarProfile"]
        
        btnEmployees.tap()
        btnSetting.tap()
        btnHome.tap()
        

    }
    
    func addEmployeeUITest(app: XCUIApplication) {
        
    }
}
