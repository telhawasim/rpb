//
//  CustomSlider.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class CustomSlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
}
