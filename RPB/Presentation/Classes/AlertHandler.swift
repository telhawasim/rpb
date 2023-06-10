//
//  AlertHandler.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

class AlertHandler: NSObject {
    
    static let shared = AlertHandler()
    
    func alert(message: String, title: String = "Error", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(alertAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let viewController = sceneDelegate.window?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
