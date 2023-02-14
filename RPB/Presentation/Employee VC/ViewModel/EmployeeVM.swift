//
//  EmployeeVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class EmployeeVM {
    
    weak var binder: EmployeeBinder?
    private var model: EmployeeModel?
    
    init(binder: EmployeeBinder) {
        self.binder = binder
        self.model = EmployeeModel()
    }
    
    func main() {
        binder?.configureFonts()
        binder?.configureTextField()
        binder?.setColors()
        binder?.registerCell()
    }
    
    func loadTableViewAnimation() {
        binder?.tableViewAnimation()
    }
    
    func goToAddEmployee() {
        binder?.goToAddEmployee()
    }
    
    func setIsLoading() {
        binder?.isLoading = false
    }
    
    deinit {
        self.model = nil
    }
}
