//
//  CustomFont.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func getRegularFont14(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Regular", size: size)!
    }

    static func getRegularFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Regular", size: size)!
    }
    
    static func getMediumFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Medium", size: size)!
    }
    
    static func getMediumFont14(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Medium", size: size)!
    }
    
    static func getSemiBoldFont(size: CGFloat = 16.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Semibold", size: size)!
    }
    
    static func getBoldFont(size: CGFloat = 18.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Bold", size: size)!
    }
    
    static func getThinFont(size: CGFloat = 14.0) -> UIFont {
        return UIFont.init(name: "Gilroy-Thin", size: size)!
    }
}

// Example
// myLabel.font = UIFont.getThinFont()
