//
//  UIView.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }

    func addShadow(shadowOpacity: Float = 0.5, shadowRaduis: Float = 10, shadowColor: CGColor = UIColor.lightGray.cgColor) {

        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = CGFloat(shadowRaduis)
        clipsToBounds = false
    }

    @discardableResult func isCircularView() -> CGFloat {
        self.layer.cornerRadius = self.frame.height / 2
        return self.layer.cornerRadius
    }

    @discardableResult func cornerRadius(_ size: CGFloat) -> CGFloat {
        self.layer.cornerRadius = size
        return self.layer.cornerRadius
    }
}
