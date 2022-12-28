//
//  CancelPopViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 28/12/2022.
//

import UIKit
import SwiftPopup

class CancelPopViewController: SwiftPopup {

    //MARK: IBOutlets
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        self.dismiss()
    }
}
