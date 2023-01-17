//
//  CustomFont.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func getDefaultFont_Thin() -> UIFont {
        return UIFont.init(name: "Montserrat-SemiBold", size: 14.0)!
    }
    
    static func getRegularFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Regular", size: size)!
    }
    
    static func getCustomFont_Medium(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Medium", size: size)!
    }
    
    static func getCustomFont_SemiBold(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-SemiBold", size: size)!
    }
    
    static func getCustomFont_Bold(size: CGFloat = 18.0) -> UIFont {
        return UIFont.init(name: "Montserrat-SemiBold", size: size)!
    }
    
    static func getCustomFont_Thin(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Thin", size: size)!
    }
}

// Example
// myLabel.font = UIFont.MontserratRegular(16)
