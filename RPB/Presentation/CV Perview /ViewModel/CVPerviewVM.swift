//
//  CVPerviewVM.swift
//  RPB
//
//  Created by Bilal Nisar on 01/02/2023.
//

import Foundation

class CVPerviewVM {
    
    //MARK: Variables
    var perviewBinder: CVPerviewBider?
    
    //MARK: Init
    init(binder: CVPerviewBider) {
        self.perviewBinder = binder
    }
    
    //MARK: Main Function
    func mainFunction() {
        perviewBinder?.registerCell()
    }
}
