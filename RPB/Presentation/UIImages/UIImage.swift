//
//  UIImage.swift
//  RPB
//
//  Created by Telha Wasim on 16/01/2023.
//

import Foundation

extension UIImage {
    
    static var placeHolder: UIImage {
        return UIImage(named: "ic_placeholder") ?? UIImage()
    }
    
    static var projectPlaceholder: UIImage {
        return UIImage(named: "ic_project_placeholder") ?? UIImage()
    }
    
    static var dropdownArrowUp: UIImage {
        return UIImage(named: "arrow_up") ?? UIImage()
    }
    static var dropdownArrowDown: UIImage {
        return UIImage(named: "arrow_down") ?? UIImage()
    }
    static var employeeListingEmptyIcon: UIImage {
        return UIImage(named: "EmptyIcon") ?? UIImage()
    }
}
