//
//  Float.swift
//  RPB
//
//  Created by Telha Wasim on 30/03/2023.
//

import Foundation

extension Float {
    func toString(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
