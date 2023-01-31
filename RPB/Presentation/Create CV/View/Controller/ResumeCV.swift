//
//  ResumeCV.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class ResumeCV: BaseVC {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: Variables
    var binder: ResumeBinder?
    var viewModel: ResumeVM?
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()

        binder = ResumeBinder(lblTitle: self.lblTitle, collectionView: self.collectionView, tableView: self.tableView, buttonView: self.buttonView, btnPreview: self.btnPreview, btnSave: self.btnSave, viewController: self)
        
        viewModel = ResumeVM(binder: self.binder!)
        
        viewModel?.main()
    }
    
    //MARK: Go back Button Pressed
    @IBAction func btnGoBack(_ sender: Any) {
        self.viewModel?.goBackPressed()
    }
    
    //MARK: Save Button Pressed
    @IBAction func btnSavePressed(_ sender: Any) {
        self.viewModel?.saveButtonPressed()
    }
    
    //MARK: Previous Button Pressed
    @IBAction func btnPreviousPressed(_ sender: Any) {
        self.viewModel?.previousButtonPressed()
    }
}
