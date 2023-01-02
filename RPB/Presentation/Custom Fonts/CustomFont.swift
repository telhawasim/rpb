//
//  CustomFont.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }

    static func montserratRegular(_ size: Int) -> UIFont {
        return customFont(name: "Montserrat-Regular", size: CGFloat(size))
    }

    static func montserratSemiBold(_ size: Int) -> UIFont {
        return customFont(name: "Montserrat-SemiBold", size: CGFloat(size))
    }

    static func montserratBold(_ size: Int) -> UIFont {
        return customFont(name: "Montserrat-Bold", size: CGFloat(size))
    }

    static func montserratMedium(_ size: Int) -> UIFont {
        return customFont(name: "Montserrat-Medium", size: CGFloat(size))
    }
    
    static func montserratThin(_ size: Int) -> UIFont {
        return customFont(name: "Montserrat-Thin", size: CGFloat(size))
    }
}

// Example
// myLabel.font = UIFont.MontserratRegular(16)
