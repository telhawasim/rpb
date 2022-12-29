//
//  ResumeCV.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

enum InfoType {
    case info
    case skills
    case experience
}

struct Section {
    var section: String!
    var rows: [Int]!
    var expanded: Bool!
    
    init(section: String!, rows: [Int], expanded: Bool!) {
        self.section = section
        self.rows = rows
        self.expanded = expanded
    }
}

class ResumeCV: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnSkills: UIButton!
    @IBOutlet weak var btnExperience: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: Variables
    var info: InfoType = .info
    var infoModel = [Section]()
    var skillsModel = [Section]()
    var selectedHeader = Int()
    var infoData = ["Name", "Designation", "Date of Birth", "Email Address", "Phone Number"]
    var infoPlaceholder = ["Dawid", "iOS Developer", "07-08-99", "dawid.name@gmail.com", "03350438764"]
    var educationData = ["School / University", "Degree", "Field of Study"]
    var educationPlaceholder = ["Virtual University", "Master's Degree", "BIT"]
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnInfoPressed(0)
        self.configureLabel()
        self.configureTableView()
        infoModel = [(Section(section: "Basic Info", rows: [1, 1, 1, 1, 1], expanded: true)),
                     (Section(section: "Education", rows: [1, 1, 1, 1, 1], expanded: false)),
                     (Section(section: "Summary", rows: [1], expanded: false))]
        
    }
    
    @objc func tapInfoSection(_ gesture: UITapGestureRecognizer) {
        if let viewTag = gesture.view?.tag {
            selectedHeader = viewTag
            if infoModel[selectedHeader].expanded == false {
                infoModel[selectedHeader].expanded = true
            } else {
                infoModel[selectedHeader].expanded = false
            }
        }
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
    }
    
    //MARK: Configure Labels
    func configureLabel() {
        self.lblTitle.font = UIFont.montserratMedium(24)
        self.configureButtons()
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnInfo.configureButton(text: "Info", borderWidth: 1, borderColor: UIColor.greyE2E2E2)
        self.btnSkills.configureButton(text: "Skills", borderWidth: 1, borderColor: UIColor.greyE2E2E2)
        self.btnExperience.configureButton(text: "Experience", borderWidth: 1, borderColor: UIColor.greyE2E2E2)
        self.btnInfo.cornerRadiusButton(20)
        self.btnSkills.cornerRadiusButton(20)
        self.btnExperience.cornerRadiusButton(20)
        self.btnPreview.configureButton(text: "Preview", borderWidth: 1, borderColor: UIColor.customBlue)
        self.btnSave.configureButton(text: "Save & Continue", borderWidth: 1, borderColor: UIColor.customBlue)
        self.btnPreview.titleLabel?.font = UIFont.montserratMedium(18)
        self.btnSave.titleLabel?.font = UIFont.montserratMedium(18)
        self.btnPreview.tintColor = UIColor.customBlue
        self.btnSave.tintColor = UIColor.white
        self.btnSave.backgroundColor = UIColor.customBlue
        self.btnSave.cornerRadiusButton(30)
        self.btnPreview.cornerRadiusButton(30)
    }
    
    //MARK: Configure TableView
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(BasicInfoTVCell.className)
        self.tableView.register(EducationTVCell.className)
        self.tableView.register(SummaryTVCell.className)
        self.tableView.register(DobTVCell.className)
        self.tableView.register(UINib(nibName: ResumeHeaderCell.className, bundle: nil), forHeaderFooterViewReuseIdentifier: ResumeHeaderCell.className)
    }
    
    //MARK: IBACTIONS
    @IBAction func btnInfoPressed(_ sender: Any) {
        self.btnInfo.inSelectedResumeCV()
        self.btnSkills.isNotSelectedResumeCV()
        self.btnExperience.isNotSelectedResumeCV()
        self.info = .info
    }
    
    @IBAction func btnSkillsPressed(_ sender: Any) {
        self.btnInfo.isNotSelectedResumeCV()
        self.btnSkills.inSelectedResumeCV()
        self.btnExperience.isNotSelectedResumeCV()
        self.info = .skills
    }
    
    @IBAction func btnExperiecePressed(_ sender: Any) {
        self.btnInfo.isNotSelectedResumeCV()
        self.btnSkills.isNotSelectedResumeCV()
        self.btnExperience.inSelectedResumeCV()
        self.info = .experience
    }
}

extension ResumeCV: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoModel.count
    }
    
    //MARK: Number of rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.infoModel[section].expanded {
            return infoModel[section].rows.count
        } else {
            return 0
        }
    }
    
    //MARK: View for Header in Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResumeHeaderCell.className) as! ResumeHeaderCell
        if section == 1 {
            headerView.btnAddMore.isHidden = false
        } else {
            headerView.btnAddMore.isHidden = true
        }
        headerView.lblHeading.text = infoModel[section].section
        headerView.lblHeading.font = UIFont.montserratMedium(20)
        if self.infoModel[section].expanded == false {
            UIView.transition(with: headerView.imgArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { headerView.imgArrow.image = UIImage(named: "arrow_right") },
                              completion: nil)
            headerView.headerView.backgroundColor = .clear
            headerView.headerView.borderWidth = 1
        } else {
            headerView.headerView.backgroundColor = UIColor.blueF1F1FF
            headerView.headerView.borderWidth = 0
            UIView.transition(with: headerView.imgArrow,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { headerView.imgArrow.image = UIImage(named: "arrow_down") },
                              completion: nil)
            
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapInfoSection(_:)))
        headerView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        headerView.tag = section
        return headerView
    }
    
    //MARK: Height for Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 95
        } else {
            return 65
        }
    }
    
    //MARK: Cell for Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // Section 1
            if indexPath.row == 2 { // Section 1 (row 3)
                let cell = tableView.dequeueReusableCell(withIdentifier: "DobTVCell", for: indexPath) as! DobTVCell
                cell.lblDate.text = infoData[indexPath.row]
                cell.txtDate.placeholder = infoPlaceholder[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
                cell.lblTitle.text = infoData[indexPath.row]
                cell.txtInfo.placeholder = infoPlaceholder[indexPath.row]
                return cell
            }
        } else if indexPath.section == 1 { // Section 2
            if indexPath.row == 0 { // Section 2 (row 1)
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
                cell.lblTitle.text = educationData[indexPath.row]
                cell.txtInfo.placeholder = educationPlaceholder[indexPath.row]
                return cell
            } else if indexPath.row == 1 { // Section 2 (row 2)
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
                cell.lblTitle.text = educationData[indexPath.row]
                cell.txtInfo.placeholder = educationPlaceholder[indexPath.row]
                return cell
            } else if indexPath.row == 2 { // Section 2 (row 3)
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
                cell.lblTitle.text = educationData[indexPath.row]
                cell.txtInfo.placeholder = educationPlaceholder[indexPath.row]
                return cell
            } else if indexPath.row == 3 { // Section 2 (row 4)
                let cell = tableView.dequeueReusableCell(withIdentifier: "EducationTVCell", for: indexPath) as! EducationTVCell
                cell.lblDate.text = "Start Date"
                cell.lblYear.text = "Year"
                return cell
            } else { // Section 2 (row 5)
                let cell = tableView.dequeueReusableCell(withIdentifier: "EducationTVCell", for: indexPath) as! EducationTVCell
                cell.lblDate.text = "End Date"
                cell.lblYear.text = "Year"
                return cell
            }
        } else { // Section 3
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTVCell", for: indexPath) as! SummaryTVCell
            return cell
        }
    }
}
