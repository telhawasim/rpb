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
    var infoType: InfoType = .info
    var infoModel = [Section]()
    var experienceModel = [Section]()
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
        experienceModel = [Section(section: "Add Experience", rows: [1, 1, 1, 1, 1, 1, 1, 1, 1], expanded: true)]
        
    }
    
    @objc func tapInfoSection(_ gesture: UITapGestureRecognizer) {
        if let viewTag = gesture.view?.tag {
            selectedHeader = viewTag
            switch infoType {
            case .info:
                if infoModel[selectedHeader].expanded == false {
                    infoModel[selectedHeader].expanded = true
                } else {
                    infoModel[selectedHeader].expanded = false
                }
            case .skills:
                return
            case .experience:
                if experienceModel[selectedHeader].expanded == false {
                    experienceModel[selectedHeader].expanded = true
                } else {
                    experienceModel[selectedHeader].expanded = false
                }
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
        self.infoType = .info
        self.tableView.reloadData()
    }
    
    @IBAction func btnSkillsPressed(_ sender: Any) {
        self.btnInfo.isNotSelectedResumeCV()
        self.btnSkills.inSelectedResumeCV()
        self.btnExperience.isNotSelectedResumeCV()
        self.infoType = .skills
        self.tableView.reloadData()
    }
    
    @IBAction func btnExperiecePressed(_ sender: Any) {
        self.btnInfo.isNotSelectedResumeCV()
        self.btnSkills.isNotSelectedResumeCV()
        self.btnExperience.inSelectedResumeCV()
        self.infoType = .experience
        self.tableView.reloadData()
    }
}

//MARK: TableView Methods
extension ResumeCV: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch infoType {
        case .info:
            return infoModel.count
        case .skills:
            return 0
        case .experience:
            return experienceModel.count
        }
    }
    
    //MARK: Number of rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch infoType {
        case .info:
            if self.infoModel[section].expanded {
                return infoModel[section].rows.count
            } else {
                return 0
            }
        case .skills:
            return 0
        case .experience:
            if self.experienceModel[section].expanded {
                return experienceModel[section].rows.count
            } else {
                return 0
            }
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
        
        switch infoType {
        case .info:
            headerView.lblHeading.text = infoModel[section].section
            headerView.lblHeading.font = UIFont.montserratMedium(20)
            headerView.tag = section
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
        case .skills:
            return UIView()
        case .experience:
            headerView.lblHeading.text = experienceModel[section].section
            headerView.lblHeading.font = UIFont.montserratMedium(20)
            headerView.tag = section
            headerView.imgArrow.image = UIImage(named: "add_more")
            if self.experienceModel[section].expanded == false {
                headerView.headerView.backgroundColor = UIColor.white
                headerView.headerView.borderWidth = 1
            } else {
                headerView.headerView.borderWidth = 0
                headerView.headerView.backgroundColor = UIColor.blueF1F1FF
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapInfoSection(_:)))
        headerView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        return headerView
        
    }
    
    //MARK: Height for Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch infoType {
        case .info:
            if section == 1 {
                return 95
            } else {
                return 65
            }
        case .skills:
            return 0
        case .experience:
            return 65
        }
        
    }
    
    //MARK: Cell for Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch infoType {
        case .info:
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
        case .skills:
            return UITableViewCell()
        case .experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
//            cell.lblTitle.text = infoData[indexPath.row]
//            cell.txtInfo.placeholder = infoPlaceholder[indexPath.row]
            return cell
        }
        
    }
}
