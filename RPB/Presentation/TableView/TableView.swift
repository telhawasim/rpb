//
//  TableView.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func registerHeaderFooter(_ name: String) {
        self.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: name)
    }
    
    func reloadWithAnimation() {
            self.reloadData()
            let tableViewHeight = self.bounds.size.height
            let cells = self.visibleCells
            var delayCounter = 0
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            }
            for cell in cells {
                UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
                delayCounter += 1
            }
        }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
