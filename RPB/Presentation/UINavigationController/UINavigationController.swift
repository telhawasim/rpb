//
//  UINavigationController.swift
//  RPB
//
//  Created by Telha Wasim on 31/03/2023.
//

import Foundation

extension UINavigationController {
    
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
