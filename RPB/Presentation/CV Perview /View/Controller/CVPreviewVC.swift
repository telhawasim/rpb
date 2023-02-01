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
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var perviewBinder: CVPerviewBider?
    var perviewViewModel: CVPerviewVM?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.perviewBinder = CVPerviewBider(lblViewProfile: self.lblViewProfile, lblName: self.lblName, btnEdit: self.btnEdit, btnDownload: self.btnDownload, tableView: self.tableView)
        self.perviewViewModel = CVPerviewVM(binder: perviewBinder!)
        self.perviewViewModel?.mainFunction()
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func btnDownloadTapped(_ sender: Any) {
        goToDownloadSection()
    }
}

