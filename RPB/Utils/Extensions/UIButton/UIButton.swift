//
//  UIButton.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var borderWidthButton: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadiusButton: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColorButton: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
    }
}

extension UIButton {
    @discardableResult func cornerRadiusButton(_ size: CGFloat) -> CGFloat {
        self.layer.cornerRadius = size
        return self.layer.cornerRadius
    }
    
    @discardableResult func isCircularButton() -> CGFloat {
        self.layer.cornerRadius = self.frame.height / 2
        return self.layer.cornerRadius
    }
    
    func configureButton(text: String, borderWidth: CGFloat, borderColor: UIColor) {
        self.setTitle(text, for: .normal)
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.titleLabel?.font = UIFont.getRegularFont(size: 14)
    }
    
    func inSelectedResumeCV() {
        self.backgroundColor = UIColor.appColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func isNotSelectedResumeCV() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
    
}
