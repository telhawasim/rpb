//
//  ProfileVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

class ProfileVM {
    
    //MARK: Variables
    weak var binder: ProfileBinder?
    private var model: ProfileModel?
    
    //MARK: Init
    init(binder: ProfileBinder) {
        self.binder = binder
        self.model = ProfileModel()
    }
    
    //MARK: Main Function
    func main() {
        self.binder?.configureButtons()
        self.binder?.configureFonts()
        self.binder?.configureTableView()
        self.binder?.configureBottomSheet()
        self.binder?.bottomSheetHeight?.constant = 0
    }
    
    func closeButtonSheet() {
        self.binder?.bottomSheetClose()
    }
    
    func reloadData() {
        self.binder?.tableView?.reloadWithAnimation()
    }
    
    func setIsLoading() {
        binder?.isLoading = false
    }
    
    func employeeData() {
        binder?.populateData()
    }
    
    func deleteButtonPressed() {
        self.closeButtonSheet()
        self.binder?.showPopUp()
    }
    
    func goBack() {
        self.binder?.goBack()
    }
    
    func goToResumeCV() {
        self.binder?.goToResumeCV()
    }
    
    deinit {
        self.model = nil
    }
}
