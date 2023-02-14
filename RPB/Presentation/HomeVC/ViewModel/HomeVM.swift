//
//  HomeVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class HomeVM {

    //MARK: Variables
    weak var binder: HomeBinder?
    private var model: HomeModel?
    
    //MARK: Init
    init(binder: HomeBinder) {
        self.binder = binder
//        self.model = HomeModel()
    }
    
    func main() {
        binder?.configureFonts()
        binder?.configTableView()
//        binder?.getData(model: self.model!)
    }
    
    func setIsLoading() {
        binder?.isLoading = false
    }
    
    func addEmpployeeButton() {
        binder?.addEmpployeeButton()
    }
    
    deinit {
        self.model = nil
    }
}
