//
//  RPBUITests.swift
//  RPBUITests
//
//  Created by Bilal Nisar on 20/12/2022.
//

import XCTest
@testable import RPB

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
    
    //MARK: Login Screen UITest
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
        
        let txtEmail = app.textFields["Please enter email"]
        XCTAssertTrue(txtEmail.exists)
        
        let txtPassword = app.secureTextFields["Please enter password"]
        XCTAssertTrue(txtPassword.exists)
        
        txtEmail.tap()
        txtEmail.typeText("admin@synavos.com")
        
        txtPassword.tap()
        txtPassword.typeText("admin@synavos")
        
        btnShowPassword.tap()
        
        btnLogin.tap()
        let loader = app.activityIndicators.firstMatch
        XCTAssertFalse(loader.waitForExistence(timeout: 5))
        homeScreenUITest(app: app)
    }
    
    //MARK: Home Screen UITest
    func homeScreenUITest(app: XCUIApplication) {
        let title = app.staticTexts["Hello"]
        XCTAssertTrue(title.exists)
        
        let employeeTotal = app.staticTexts["Total Employees"]
        XCTAssertTrue(employeeTotal.exists)
        
        func testEmployeeCountAPI() {
            // Make a network request to fetch employee count from the API
            let expectation = XCTestExpectation(description: "Fetch employee count API")
            UserService.shared.fetchEmployeeCount { result in
                switch result {
                case .success(let stats):
                    // Update the UI with the fetched employee count
                    let app = XCUIApplication()
                    app.launch()
                    app.staticTexts["employeeCountLabel"].typeText(String(stats.data?.totalEmployees ?? 0))
                    
                    // Verify that the updated employee count is displayed on the UI
                    XCTAssertEqual(app.staticTexts["employeeCountLabel"].label, String(stats.data?.totalEmployees ?? 0), "Employee count on UI should match API response")
                    
                    // Fulfill the expectation to indicate that the test case has completed
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Failed to fetch employee count: \(error.localizedDescription)")
                }
            }
        }
        addEmployeeUITest(app: app)
    }
    
    //MARK: Add Employee UITest
    func addEmployeeUITest(app: XCUIApplication) {
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        // Image
        app.buttons["btnAddEmployee"].tap()
        app.buttons["addimage"].tap()
        app.scrollViews.otherElements.buttons["Gallery"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 31, 2018, 12:14 AM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 31, 2018, 12:14 AM, Photo, August 09, 2012, 2:55 AM, Photo, August 09, 2012, 2:29 AM, Photo, August 08, 2012, 11:52 PM, Photo, October 10, 2009, 3:09 AM, Photo, March 13, 2011, 5:17 AM\"].images[\"Photo, March 31, 2018, 12:14 AM\"]",".images[\"Photo, March 31, 2018, 12:14 AM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["Choose"].tap()
        
        // Name
        elementsQuery.textFields["Enter name"].tap()
        elementsQuery.textFields.element(boundBy: 0).typeText("POC Team")
    
        // Designation
        app.scrollViews.otherElements.textFields["Select Designation"].tap()
        app.pickerWheels["Software Engineer"].tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // Department
        app.scrollViews.otherElements.textFields["Select Department"].tap()
        app.pickerWheels["Creative"].adjust(toPickerWheelValue: "Engineering")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // DOB
        let element = app.scrollViews.otherElements.containing(.button, identifier: "Add").children(matching: .other).element.children(matching: .other).element(boundBy: 3)
        element.tap()
        element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        
        elementsQuery.textFields["Select date of birth"].tap()
        
        let datePickerQuery = app.datePickers
        let datePickerQuery2 = datePickerQuery
        
        datePickerQuery2.buttons["Show year picker"].tap()
        
        let datePickerQuery3 = datePickerQuery2.datePickers
        datePickerQuery3.pickerWheels["2023"].adjust(toPickerWheelValue: "1999")
        datePickerQuery3.pickerWheels["April"].adjust(toPickerWheelValue: "August")
        
        datePickerQuery2.buttons["Hide year picker"].tap()
        datePickerQuery.collectionViews.buttons["Saturday, August 7"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // Email
        let txtEmail = elementsQuery.textFields.element(boundBy: 4)
        txtEmail.tap()
        txtEmail.typeText("poc@gmail.com")
        
        // Phone number
        let txtPhone = elementsQuery.textFields.element(boundBy: 5)
        txtPhone.tap()
        txtPhone.typeText("03350438764")
        
        // Joining Date
        let elementJoining = app.scrollViews.otherElements.containing(.button, identifier: "Add").children(matching: .other).element.children(matching: .other).element(boundBy: 6)
        elementJoining.tap()
        elementJoining.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        
        elementsQuery.textFields["Select date of joining"].tap()
        
        let datePickerJoiningQuery = app.datePickers
        let datePickerJoiningQuery2 = datePickerJoiningQuery
        
        datePickerJoiningQuery2.buttons["Show year picker"].tap()
        
        let datePickerJoiningQuery3 = datePickerJoiningQuery2.datePickers
        
        datePickerJoiningQuery3.pickerWheels["2023"].adjust(toPickerWheelValue: "2022")
        datePickerJoiningQuery3.pickerWheels["April"].adjust(toPickerWheelValue: "May")
        
        datePickerJoiningQuery2.buttons["Hide year picker"].tap()
        datePickerJoiningQuery.collectionViews.buttons["Monday, May 9"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        app.scrollViews.buttons["Add"].tap()
        // Go Back
        profileScreenUITest(app: app)
    }
    
    //MARK: Profile UITest
    func profileScreenUITest(app: XCUIApplication) {
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        app.buttons["btnCreateProfile"].tap()
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("iOS Developer")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Done"].tap()
        
        self.createCVScreenUITest(app: app)
        
//        app.buttons["btnGoBack"].tap()
//        app.buttons["btnYesDiscardInformation"].tap()

//        let employeeName = app.staticTexts["Noman"]
//        XCTAssertTrue(employeeName.waitForExistence(timeout: 3))
//
//        app.tables.children(matching: .cell).element(boundBy: 0).buttons["ic dots"].tap()
//        app.buttons["cross 20x20"].tap()
//        app.buttons["add cv"].tap()
        
//        createCVScreenUITest(app: app)
    }
    
    func createCVScreenUITest(app: XCUIApplication) {
        //MARK: Basic Info
        
        // Name
        let tableQuery = app.tables
//        tableQuery.textFields["Enter name"].tap()
//        tableQuery.textFields.element(boundBy: 0).typeText("Telha Wasim")
        
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
//        doneButton.tap()
        
//        // Designation
//        tableQuery.textFields["Select Designation"].tap()
//        tableQuery.textFields.element(boundBy: 1).typeText("IOS Developer")
//        doneButton.tap()
//
//        // Email
//        tableQuery.textFields["dawid.name@gmail.com"].tap()
//        tableQuery.textFields.element(boundBy: 2).typeText("telhawasim@gmail.com")
//        doneButton.tap()
//
//        // Phone Number
//        tableQuery.textFields["03350438764"].tap()
//        tableQuery.textFields.element(boundBy: 3).typeText("03350438764")
//        doneButton.tap()
        
        // BitBucket
        tableQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element.tap()
        tableQuery.textFields["Enter git/bit bucket"].swipeUp()
        tableQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element.typeText("https://www.git.com")
        doneButton.tap()
//
//        // LinkedIn
        tableQuery.textFields["Enter linkedin"].tap()
        tableQuery.textFields.element(boundBy: 5).typeText("https://linkedin.com")
        doneButton.tap()
        
        // Summary
        tableQuery.children(matching: .cell).element(boundBy: 6).children(matching: .textView).element.tap()
        tableQuery.children(matching: .cell).element(boundBy: 6).children(matching: .textView).element.typeText("My name is poc")
        doneButton.tap()
        
        // Done Button
        app.staticTexts["Save & Continue"].tap()
        
        //MARK: Experience
        
        // Past Experience
        tableQuery.textFields["Enter start date"].tap()
//        doneButton.tap()
        app.buttons["Done"].staticTexts["Done"].tap()
        
        
        tableQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element.tap()
        tableQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element.typeText("Synavos is my first company")
        doneButton.tap()
        
        // Done Button
        app.staticTexts["Save & Continue"].tap()
        
        //MARK: Skills & Certificates
        
        // Skills
        let cellsQuery1 = app.tables.cells.containing(.staticText, identifier: "1")
        cellsQuery1.textFields["Enter skills"].tap()
        cellsQuery1.textFields["Enter skills"].typeText("Swift")
        doneButton.tap()
        cellsQuery1.sliders["0%"].adjust(toNormalizedSliderPosition: 0.75)
        cellsQuery1.sliders.element.swipeUp()
        
        let cellsQuery2 = app.tables.cells.containing(.staticText, identifier: "2")
        cellsQuery2.textFields["Enter skills"].tap()
        cellsQuery2.textFields["Enter skills"].typeText("SwiftUI")
        doneButton.tap()
        cellsQuery2.sliders["0%"].adjust(toNormalizedSliderPosition: 0.45)
        
        let cellsQuery3 = app.tables.cells.containing(.staticText, identifier: "3")
        cellsQuery3.textFields["Enter skills"].tap()
        cellsQuery3.textFields["Enter skills"].typeText("IOS")
        doneButton.tap()
        cellsQuery3.sliders["0%"].adjust(toNormalizedSliderPosition: 0.25)
        
        let cellsQuery4 = app.tables.cells.containing(.staticText, identifier: "4")
        cellsQuery4.textFields["Enter skills"].tap()
        cellsQuery4.textFields["Enter skills"].typeText("IOS Development")
        doneButton.tap()
        cellsQuery4.sliders["0%"].adjust(toNormalizedSliderPosition: 0.35)
        
        
        app.staticTexts["Save & Continue"].tap()

        // Certificates
//        tableQuery.buttons["Add Here"].tap()
//        // Course Name
//        tableQuery.textFields["Enter course name"].tap()
//        tableQuery.textFields["Enter course name"].typeText("Swift Complete Tutorial (UIKit)")
//        doneButton.tap()
//
//        // Course From
//        tableQuery.textFields["Enter institution"].tap()
//        tableQuery.textFields["Enter institution"].typeText("Udemy")
//        doneButton.tap()
//
//        // Course Start Date
//        tableQuery.textFields["Enter start date"].tap()
////        let cell = tableQuery.cells
////        cell.textFields["Enter start date"].tap()
//        app.buttons["Done"].staticTexts["Done"].tap()
//
//        //Course End Date
//        tableQuery.textFields["Enter end date"].tap()
////        cell.textFields["Enter end date"]
//        app.buttons["Done"].staticTexts["Done"].tap()
//        // Done Button
//        app.staticTexts["Save & Continue"].tap()
//
        //MARK: Academics
        // Degree
        tableQuery.cells.textFields["Enter degree"].tap()
        tableQuery.cells.textFields["Enter degree"].typeText("BSCS")
        doneButton.tap()
        
        // Institute
        tableQuery.cells.textFields["Enter institution"].tap()
        tableQuery.cells.textFields["Enter institution"].typeText("Comsats University")
        doneButton.tap()
        
        // Starts From
        let academicCell = tableQuery.cells
        academicCell.textFields["Enter start date"].tap()
        app.buttons["Done"].staticTexts["Done"].tap()
        // Ends To
        academicCell.textFields["Enter end date"].tap()
        app.buttons["Done"].staticTexts["Done"].tap()
        
        // Done Button
        app.staticTexts["Save & Continue"].tap()
        //self.previewProfile(app: app)
    }
    
//    func previewProfile(app: XCUIApplication) {
//        let tablesQuery = app.tables
//        tablesQuery.cells.containing(.staticText, identifier:"Skills").element.swipeUp()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Software Engineer"]/*[[".cells.staticTexts[\"Software Engineer\"]",".staticTexts[\"Software Engineer\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Education"]/*[[".cells.staticTexts[\"Education\"]",".staticTexts[\"Education\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["BSCS"]/*[[".cells.staticTexts[\"BSCS\"]",".staticTexts[\"BSCS\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Work Experience"]/*[[".cells.staticTexts[\"Work Experience\"]",".staticTexts[\"Work Experience\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
//
//    }
}
