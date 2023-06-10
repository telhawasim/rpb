//
//  CVPreviewVC.swift
//  RPB
//
//  Created by Bilal Nisar on 27/12/2022.
//

import UIKit

class CVPreviewVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var lblViewProfile: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var binder: CVPreviewBinder?
    var viewModel: CVPerviewVM?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binder = CVPreviewBinder(lblViewProfile: self.lblViewProfile, lblName: self.lblName, btnEdit: self.btnEdit, btnDownload: self.btnDownload, btnDelete: self.btnDelete, tableView: self.tableView, profileImage: self.profileImage, lblDesignation: self.lblDesignation)
        if viewModel == nil {
            viewModel = CVPerviewVM(binder: self.binder!, viewController: self)
        } else {
            viewModel?.binder = self.binder
            viewModel?.viewController = self
        }

        self.viewModel?.mainFunction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fetchProfileDetail()

    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        self.viewModel?.editProfile()
    }
    
    @IBAction func btnDeleteProfile(_ sender: Any) {
        self.viewModel?.deleteProfile()
    }
    
    @IBAction func btnDownloadTapped(_ sender: Any) {
        self.viewModel?.exportPdf()
    }
}
