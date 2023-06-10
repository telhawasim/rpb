//
//  HomeTestCase.swift
//  RPBTests
//
//  Created by Noman Akram on 28/02/2023.
//

import XCTest
@testable import RPB

class HomeTestCase: XCTestCase {
    
    var homeBinder: HomeBinder!
    var tableView: UITableView!
    var lblEmployeeCount: UILabel!
    var lblTotalEmployee: UILabel!
    var lblName: UILabel!
    var lblEmployee: UILabel!
    
    override func setUp() {
        super.setUp()
        
        // Instantiate the objects needed for HomeBinder
        tableView = UITableView()
        lblEmployeeCount = UILabel()
        lblTotalEmployee = UILabel()
        lblName = UILabel()
        lblEmployee = UILabel()
        
        // Instantiate the HomeBinder object
        homeBinder = HomeBinder(tableView: tableView, lblEmployeeCount: lblEmployeeCount, lblTotalEmployee: lblTotalEmployee, lblName: lblName, lblEmployee: lblEmployee)
        
        // Call the methods in HomeBinder to set up the view
        homeBinder.configureFonts()
        homeBinder.configTableView()
    }
    
    override func tearDown() {
        tableView = nil
        lblEmployeeCount = nil
        lblTotalEmployee = nil
        lblName = nil
        lblEmployee = nil
        homeBinder = nil
        
        super.tearDown()
    }
    
    func testSetColors() {
        // Call the method
        homeBinder.setColors()
        
        // Assert that the labels have the correct colors
        XCTAssertEqual(lblName.textColor, UIColor.customBlack)
        XCTAssertEqual(lblEmployee.textColor, UIColor.customBlack)
    }
    
    //MARK: Api Unit Test
    func testCheckTotalEmployeeCount() {
        var data: HomeModel?
        
        let expectation = XCTestExpectation(description: "Fetch data")
        
        UserService.shared.fetchEmployeeCount { status in
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
    
    
    // Test if the table view is set up correctly
    func testConfigTableView() {
        // Check that the delegate and dataSource are set to HomeBinder
        XCTAssertEqual(tableView.delegate as? HomeBinder, homeBinder)
        XCTAssertEqual(tableView.dataSource as? HomeBinder, homeBinder)
        
        // Check that the table view is registered with the correct cell
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className)
        XCTAssertNotNil(cell)
    }
    
    // Test if the incrementedValue() method increments the employee count label correctly
    //    func testIncrementedValue() {
    //        // Call the method
    //        homeBinder.incrementedValue()
    //
    //        // Assert that the label has the correct value after the method call
    //        XCTAssertEqual(lblEmployeeCount.text, "1")
    //    }
    
    // Test Number of rows in cell if isLoading is true or false
    func testNumberOfRowsInSection() {
        // Test for when isLoading is true
        homeBinder.isLoading = true
        XCTAssertEqual(homeBinder.tableView(tableView, numberOfRowsInSection: 0), 3)
        
        // Test for when isLoading is false
        homeBinder.isLoading = false
        // XCTAssertEqual(homeBinder.tableView(tableView, numberOfRowsInSection: 0), homeBinder.employeeData.count)
    }
    
    // Test Cell for row at when isLoading is true or false
    func testCellForRowAt() {
        // Test for when isLoading is true
        homeBinder.isLoading = true
        let cell1 = homeBinder.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! EmployeesTableViewCell
        
        //Test for when isLoading is false
        homeBinder.isLoading = false
        let cell2 = homeBinder.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! EmployeesTableViewCell
        XCTAssertNotNil(cell2)
        //        XCTAssertEqual(cell2.lblName.text, homeBinder.employeeData[0].name)
        //        XCTAssertEqual(cell2.lblEmail.text, homeBinder.employeeData[0].email)
        //        XCTAssertEqual(cell2.lblDesignation.text, homeBinder.employeeData[0].designation)
        //        XCTAssertEqual(cell2.profilePicture.image, UIImage(named: homeBinder.employeeData[0].profilePicture))
    }
    
    // Test Did Select Row At
    func testDidSelectRowAt() {
        var selectedProfileId: String?
        homeBinder.didTapProfileAt = { profileId in
            selectedProfileId = profileId
        }
        homeBinder.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(selectedProfileId)
    }
}
