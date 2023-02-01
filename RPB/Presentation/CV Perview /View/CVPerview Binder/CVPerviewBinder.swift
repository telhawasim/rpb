//
//  CVPerviewBinder.swift
//  RPB
//
//  Created by Bilal Nisar on 01/02/2023.
//

import Foundation

class CVPerviewBider: NSObject {
    
    //MARK: IBOutlets
    weak var lblViewProfile: UILabel?
    weak var lblName: UILabel?
    weak var btnEdit: UIButton?
    weak var btnDownload: UIButton?
    weak var tableView: UITableView?
    
    //MARK: Variables
    var tags = ReadMoreModel.getTags()
    
    //MARK: Initialzation
    init(lblViewProfile: UILabel, lblName: UILabel, btnEdit: UIButton, btnDownload: UIButton, tableView: UITableView) {
        self.lblViewProfile = lblViewProfile
        self.lblName = lblName
        self.btnEdit = btnEdit
        self.btnDownload = btnDownload
        self.tableView = tableView
    }
}

// MARK: TableView Methods
extension CVPerviewBider: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as! ContactTableViewCell
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.topConstraint.constant = 20
            cell.middleConstraint.constant = 20
            cell.lblPerviousCompany.isHidden = true
            cell.lblDescriptionHeading.font = UIFont.getRegularFont(size: 20)
            cell.configure(tags[indexPath.row - 1], index: indexPath.row - 1)
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = "Work Experience"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.topConstraint.constant = 10
            cell.lblPerviousCompany.isHidden = false
            cell.configure(tags[indexPath.row - 2], index: indexPath.row - 2)
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.topConstraint.constant = 0
            cell.lblPerviousCompany.isHidden = false
            cell.configure(tags[indexPath.row - 2], index: indexPath.row - 2)
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.topConstraint.constant = 0
            // cell.lblDescriptionHeading.text = "IOS Developer"
            cell.lblPerviousCompany.isHidden = false
            // cell.lblPerviousCompany.text = "Pure Logics"
            cell.configure(tags[indexPath.row - 2], index: indexPath.row - 2)
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = "Education"
            cell.topConstraint.constant = 10
            return cell
        } else if indexPath.row  == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            return cell
        } else if indexPath.row  == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            return cell
        } else if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = "Skills"
            cell.topConstraint.constant = 20
            return cell
        } else if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            return cell
        } else if indexPath.row == 11 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            return cell
        } else if indexPath.row == 12 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            return cell
        } else if indexPath.row == 13 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            return cell
        } else if indexPath.row == 14 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            return cell
        } else if indexPath.row == 15 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = "Certifications"
            cell.topConstraint.constant = 20
            return cell
        } else if indexPath.row == 16 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            cell.lblMasterText.text = "Google UX Specialization"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            cell.lblMasterText.text = "Google UX Specialization"
            return cell
        }
    }
}

extension CVPerviewBider {
    //MARK: Register Cell
    func registerCell() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(EventDescriptionTableViewCell.className)
        tableView?.register(EducationTableViewCell.className)
        tableView?.register(SkillsTableViewCell.className)
        tableView?.register(ExperienceTableViewCell.className)
        tableView?.register(ContactTableViewCell.className)
        tableView?.register(EducationTextTableViewCell.className)
        
        self.configureFonts()
        self.configureButtons()
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnEdit?.isCircularButton()
        self.btnEdit?.backgroundColor = UIColor.dark6A90FF
        self.btnDownload?.backgroundColor = UIColor.dark6A90FF
        self.btnDownload?.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblViewProfile?.font = UIFont.getMediumFont(size: 22)
        self.lblName?.font = UIFont.getSemiBoldFont(size: 24)
        
        self.btnEdit?.setImage(UIImage(named: "edit_profile"), for: .normal)
        self.btnEdit?.setImageTintColor(UIColor.white)
        
        self.btnDownload?.setImage(UIImage(named: "download_profile"), for: .normal)
        self.btnDownload?.setImageTintColor(UIColor.white)
    }
}

extension CVPerviewBider: EventDescriptionDelegate {
    func didChangeExpantion(index: Int, isExpanded: Bool) {
        self.tags[index].isExpanded = isExpanded
        self.tableView?.reloadData()
    }
}

