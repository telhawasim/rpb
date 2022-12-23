//
//  UIImageView.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    @discardableResult func isCircular() -> CGFloat {
        self.layer.cornerRadius = self.frame.height / 2
        return self.layer.cornerRadius
    }
}
