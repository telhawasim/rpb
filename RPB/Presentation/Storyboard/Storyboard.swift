//
//  Storyboard.swift
//  RPB
//
//  Created by Bilal Nisar on 26/12/2022.
//

import Foundation

//
//  AppStoryboards.swift
//  febys
//
//  Created by Waseem Nasir on 26/06/2021.
//

import UIKit

extension UIStoryboard {

    // MARK: Generic Public/Instance Methods
    func loadViewController(withIdentifier identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }

    // MARK: Class Methods to load Storyboards
    class func storyBoard(withName name: Storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: Bundle.main)
    }

    class func storyBoard(withTextName name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }

    class func getVC(from: Storyboards, _ name: String) -> UIViewController {
        return UIStoryboard(name: from.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: name)
    }
}

enum Storyboards: String {
    // All Storyboards
    case main = "Main"
}
