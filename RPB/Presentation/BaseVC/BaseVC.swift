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
    
    //MARK: Dismiss ViewController
    func dismissVC(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
    
    //MARK: Go Back
    func goBack() {
        self.navigationController?.popToViewController(ofClass: ProfileVC.self)
    }
    
    //MARK: Go to Resume CV Screen
    func goToResumeCV() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ResumeCV.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Go to Preview CV Screen
    func goToPreviewCV() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, CVPreviewVC.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Go to Add Employee Screen
    func goToAddEmployee() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, AddEmployeeVC.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Go to Profile Screen
    func goToProfile() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ProfileVC.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Go to Download Screen
    func goToDownloadSection() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, DownloadPopupVC.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
}
