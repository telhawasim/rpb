//
//  TableView.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import Foundation
import UIKit

extension UITableView{
    func register(_ name: String){
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func registerHeaderFooter(_ name: String){
        self.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
