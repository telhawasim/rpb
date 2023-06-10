//
//  TextView.swift
//  RPB
//
//  Created by Telha Wasim on 27/12/2022.
//

import Foundation
import UIKit

extension UITextView {
    
    func addPadding(size: CGFloat) {
        self.textContainerInset = UIEdgeInsets(top: size, left: size-5, bottom: size, right: size)
    }
}
