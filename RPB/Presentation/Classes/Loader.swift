//
//  Loader.swift
//  RPB
//
//  Created by Telha Wasim on 28/02/2023.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Loader {
    private static var activityIndicatorView: NVActivityIndicatorView?
    private static var overlayView: UIView?
    
    static func start() {
        DispatchQueue.main.async {
            guard let keyWindowScene = UIApplication.shared.connectedScenes.first,
                  let keyWindow = keyWindowScene as? UIWindowScene,
                  let rootViewController = keyWindow.windows.first?.rootViewController else {
                return
            }
            // Add the overlay view
            overlayView = UIView(frame: rootViewController.view.bounds)
            overlayView?.backgroundColor = UIColor.clear
            overlayView?.isUserInteractionEnabled = true
            rootViewController.view.addSubview(overlayView!)
            
            // Show the activity indicator
            activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), type: .ballPulse, color: UIColor.appColor)
            activityIndicatorView?.center = overlayView!.center
            overlayView?.addSubview(activityIndicatorView!)
            activityIndicatorView?.startAnimating()
        }
        
    }
    
    static func stop() {
        DispatchQueue.main.async {
            // Remove the activity indicator
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
            
            // Remove the overlay view
            overlayView?.removeFromSuperview()
            overlayView = nil
        }
        
    }
}
