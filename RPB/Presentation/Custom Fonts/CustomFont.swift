//
//  CustomFont.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIFont {

    static func getRegularFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Regular", size: size)!
    }
    
    static func getMediumFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Medium", size: size)!
    }
    
    static func getMediumFont14(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Medium", size: size)!
    }
    
    static func getSemiBoldFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Montserrat-SemiBold", size: size)!
    }
    
    static func getBoldFont(size: CGFloat = 18.0) -> UIFont {
        return UIFont.init(name: "Montserrat-SemiBold", size: size)!
    }
    
    static func getThinFont(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Montserrat-Thin", size: size)!
    }
    
    static func getGilroyRegularFont(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Regular", size: size)!
    }
    
    static func getGilroyMediumFont(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Medium", size: size)!
    }
}

// Example
// myLabel.font = UIFont.getThinFont()
