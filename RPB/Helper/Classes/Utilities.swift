//
//  Utilities.swift
//  RPB
//
//  Created by Telha Wasim on 21/05/2023.
//

import Foundation
import UIKit
import SkeletonView

class Utilities {
    
    class func showSkeletonForViews(targetViews: [UIView]) {
        for view in targetViews {
            view.showAnimatedGradientSkeleton()
        }
    }
    
    class func hideSkeletonForViews(targetViews: [UIView]) {
        for view in targetViews {
            view.hideSkeleton()
        }
    }
}
