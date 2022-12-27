//
//  BaseVC.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import UIKit

class BaseVC: UIViewController {

    // MARK: IBOutlets

    // MARK: Variables

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Alert
    func alert(message: String, title: String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("")
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
