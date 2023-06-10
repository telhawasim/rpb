//
//  PopUpView.swift
//  RPB
//
//  Created by Telha Wasim on 28/12/2022.
//

import Foundation
import UIKit

class PopupView {
    static let shared = PopupView()
    
    func presentCancelPopup(_ viewController: UIViewController, popupType: PopupType?, completionHandler: PopupViewCompletionHandler? = nil) {
        let cancelCV = CancelPopViewController()
        cancelCV.popupType = popupType
        cancelCV.completionHandler = completionHandler
        cancelCV.modalTransitionStyle = .crossDissolve
        cancelCV.modalPresentationStyle = .overCurrentContext
        viewController.view.endEditing(true)
        viewController.present(cancelCV, animated: true)
    }
    
    func presentProfilePopup(_ viewController: UIViewController, completionHandler: PopupViewProfileCompletionHandler? = nil) {
        let profileCV = ProfilePopUpViewController()
        profileCV.completionHandler = completionHandler
        profileCV.modalTransitionStyle = .crossDissolve
        profileCV.modalPresentationStyle = .overCurrentContext
        viewController.view.endEditing(true)
        viewController.present(profileCV, animated: true)
    }
}
