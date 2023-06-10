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
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 9))
    }
}
