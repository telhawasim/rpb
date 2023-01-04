//
//  RPBUITests.swift
//  RPBUITests
//
//  Created by Bilal Nisar on 20/12/2022.
//

import XCTest

final class RPBUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        loginScreenUITest(app: app)
        
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
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
        
        app.buttons.element(boundBy: 0).tap()
        addEmployeeUITest(app: app)
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["iOS Developer"].tap()
        profileScreenUITest(app: app)

        //
        //        app.buttons["arrow left"].tap()
        //
        //        app.buttons["Home"].tap()
        //        app.buttons["Employee"].tap()
        //        app.buttons["TabbarProfile"].tap()
        //
        //        app.buttons["Home"].tap()
        //        app.buttons.matching(identifier: "AddEmployee").element(boundBy: 0)
        //
        //        app.buttons["AddEmployee"].tap()
        //        app.buttons["cross 20x20"].tap()
        //        app.buttons["Yes"].tap()
        
    }
    
    func addEmployeeUITest(app: XCUIApplication) {
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        //Image
        app.buttons["add image"].tap()
        app.buttons["Gallery"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 31, 2018, 12:14 AM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 31, 2018, 12:14 AM, Photo, August 09, 2012, 2:55 AM, Photo, August 09, 2012, 2:29 AM, Photo, August 08, 2012, 11:52 PM, Photo, October 10, 2009, 3:09 AM, Photo, March 13, 2011, 5:17 AM\"].images[\"Photo, March 31, 2018, 12:14 AM\"]",".images[\"Photo, March 31, 2018, 12:14 AM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Choose"].tap()
        
        // Name
        scrollViewsQuery.textFields.element(boundBy: 0).tap()
        scrollViewsQuery.textFields.element(boundBy: 0).typeText("Telha Wasim")
        
        // Designation
        elementsQuery.textFields.element(boundBy: 1).tap()
        elementsQuery.textFields.element(boundBy: 1).typeText("iOS Developer")
        
        // Department
        elementsQuery.containing(.button, identifier: "Add").children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Development")
        
        // DOB
        let element = app.scrollViews.otherElements.containing(.button, identifier: "Add").children(matching: .other).element.children(matching: .other).element(boundBy: 3)
        element.tap()
        element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        
        let datePickerDOBQuery = app.datePickers
        
        datePickerDOBQuery.pickerWheels["2023"].adjust(toPickerWheelValue: "1999")
        datePickerDOBQuery.pickerWheels["4"].adjust(toPickerWheelValue: "7")
        datePickerDOBQuery.pickerWheels["January"].adjust(toPickerWheelValue: "August")
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // Email
        let txtEmail = elementsQuery.textFields.element(boundBy: 4)
        txtEmail.tap()
        txtEmail.typeText("telhawasim@gmail.com")
        
        // Phone number
        let txtPhone = elementsQuery.textFields.element(boundBy: 5)
        txtPhone.tap()
        txtPhone.typeText("03350438764")
        
        // Joining Date
        let elementJoining = app.scrollViews.otherElements.containing(.button, identifier: "Add").children(matching: .other).element.children(matching: .other).element(boundBy: 6)
        elementJoining.tap()
        elementJoining.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        
        let datePickerJoiningQuery = app.datePickers
        
        datePickerJoiningQuery.pickerWheels["2023"].adjust(toPickerWheelValue: "2022")
        datePickerJoiningQuery.pickerWheels["4"].adjust(toPickerWheelValue: "9")
        datePickerJoiningQuery.pickerWheels["January"].adjust(toPickerWheelValue: "May")
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Add"].tap()
        
        // Go Back
        app.buttons["cross 20x20"].tap()
        app.buttons["Yes"].tap()
    }
    
    func profileScreenUITest(app: XCUIApplication) {
        app.tables.children(matching: .cell).element(boundBy: 0).buttons["ic dots"].tap()
        app.buttons["cross 20x20"].tap()
        app.buttons["add cv"].tap()
        app.buttons.element(boundBy: 0).tap()
//        app.buttons["arrow left"].tap()
    }
}
