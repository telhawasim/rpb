//
//  ResumeVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit

class ResumeVM {
    
    weak var binder: ResumeBinder?
    private var model: ResumeModel?
    
    //MARK: Init
    init(binder: ResumeBinder) {
        self.binder = binder
        self.model = ResumeModel()
    }
    
    func main() {
        self.binder?.configureLabel()
        self.binder?.configureTableView()
        self.binder?.configureCollectionView()
        self.binder?.configureButtons()
        self.binder?.btnSave?.isEnabled = false
        self.binder?.btnSave?.backgroundColor = UIColor.systemGray
        self.binder?.tableView?.estimatedRowHeight = 80.0
        self.binder?.tableView?.rowHeight = UITableView.automaticDimension
    }
    
    func saveButtonPressed() {
        self.binder?.saveButtonPressed()
    }
    
    func previousButtonPressed() {
        self.binder?.previousButtonPressed()
    }
    
    func goBackPressed() {
        self.binder?.goBackPressed()
    }
}
