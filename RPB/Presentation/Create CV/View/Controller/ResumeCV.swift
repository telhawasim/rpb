//
//  ResumeCV.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class ResumeCV: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var startDatePicker: MonthYearWheelPicker!
    @IBOutlet weak var endDatePicker: MonthYearWheelPicker!
    @IBOutlet weak var startDateViewPicker: UIView!
    @IBOutlet weak var endDateViewPicker: UIView!
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    //MARK: Variables
    var binder: ResumeBinder?
    var viewModel: ResumeVM?
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()

        binder = ResumeBinder(lblTitle: self.lblTitle, collectionView: self.collectionView, tableView: self.tableView, buttonView: self.buttonView, btnPreview: self.btnPreview, btnSave: self.btnSave, viewController: self, startDatePicker: self.startDatePicker, endDatePicker: self.endDatePicker, startDateViewPicker: self.startDateViewPicker, endDateViewPicker: self.endDateViewPicker ,superView: self.superView, overlayView: self.overlayView) { [weak self] (button) in
            switch self!.binder?.category {
            case .info:
                self?.viewModel?.putInfoInformation()
            case .experience:
                self?.viewModel?.putExperienceInformation()
            case .academics:
                self?.viewModel?.putAcademicInformation()
            case .skills:
                self?.viewModel?.putSkillsInformation()
            case .projects:
                self?.viewModel?.putProjetcsInformation()
            default:
                return
            }
        }
                
        if viewModel == nil {
            viewModel = ResumeVM(binder: binder!, viewController: self)
        } else {
            viewModel?.binder = self.binder
            viewModel?.viewController = self
        }
        
        viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel?.fetchDesignations()

        }
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
    
    //MARK: Done Button of Start Date
    @IBAction func btnDonePressed(_ sender: UIButton) {
        self.viewModel?.btnStartDatePressed(sender)
    }
}
