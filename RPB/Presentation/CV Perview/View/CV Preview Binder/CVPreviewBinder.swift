//
//  CVPerviewBinder.swift
//  RPB
//
//  Created by Bilal Nisar on 01/02/2023.
//

import Foundation
import UIKit

class CVPreviewBinder: NSObject {
    
    //MARK: IBOutlets
    weak var lblViewProfile: UILabel?
    weak var lblName: UILabel?
    weak var btnEdit: UIButton?
    weak var btnDownload: UIButton?
    weak var btnDelete: UIButton?
    weak var tableView: UITableView?
    weak var profileImage: UIImageView?
    weak var lblDesignation: UILabel?
    
    //MARK: Variables
    var tags = ReadMoreModel.getTags()
    var profileDetail: ResumeResponse?
    
    //MARK: Initialzation
    init(lblViewProfile: UILabel, lblName: UILabel, btnEdit: UIButton, btnDownload: UIButton, btnDelete: UIButton, tableView: UITableView, profileImage: UIImageView, lblDesignation: UILabel) {
        self.lblViewProfile = lblViewProfile
        self.lblName = lblName
        self.btnEdit = btnEdit
        self.btnDownload = btnDownload
        self.btnDelete = btnDelete
        self.tableView = tableView
        self.profileImage = profileImage
        self.lblDesignation = lblDesignation
    }
    
    func experiencesFetched() {
        var experienceIndex = 0
        self.profileDetail?.data?.experiences?.forEach({ eachExperience in
            self.tags.append(ReadMoreModel(tag: experienceIndex, description: "Exp", perviousCompany: "dummy"))
            experienceIndex += 1
        })
    }
}

extension CVPreviewBinder {
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
        tableView?.register(ProjectsTableViewCell.className)
        tableView?.register(AwardsHonorTVCell.className)
        
        self.configureFonts()
        self.configureButtons()
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnEdit?.isCircularButton()
        self.btnEdit?.backgroundColor = UIColor.dark6A90FF
        self.btnDownload?.backgroundColor = UIColor.dark6A90FF
        self.btnDelete?.backgroundColor = UIColor.dark6A90FF
        self.btnDownload?.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblViewProfile?.font = UIFont.getMediumFont(size: 25)
        self.lblName?.font = UIFont.getBoldFont(size: 32)
        
        self.btnEdit?.setImage(UIImage(named: "edit_profile"), for: .normal)
        self.btnEdit?.setImageTintColor(UIColor.white)
        
        self.btnDownload?.setImage(UIImage(named: "download_profile"), for: .normal)
        self.btnDownload?.setImageTintColor(UIColor.white)
        
        self.lblDesignation?.font = UIFont.getMediumFont()
        self.lblDesignation?.textColor = UIColor.gray4D4D4D
    }
}

extension CVPreviewBinder: EventDescriptionDelegate {
    func didChangeExpantion(index: Int, isExpanded: Bool) {
        self.tags[index].isExpanded = isExpanded
        self.tableView?.reloadData()
    }
}

// MARK: TableView Methods
extension CVPreviewBinder: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // Contacts
            return 1
        case 1: // Summary
            return 1
        case 2: // Experience
            return 1
        case 3: // Experience details
            return profileDetail?.data?.experiences?.count ?? 0
        case 4: // Academics
            return 1
        case 5: // Academic details
            return profileDetail?.data?.academics?.count ?? 0
        case 6: // Certificates
            return profileDetail?.data?.certificates?.count == 0 ? 0 : 1
        case 7: // Certificate details
            return profileDetail?.data?.certificates?.count ?? 0
        case 8: // Awards
            return profileDetail?.data?.awardsAndHonors?.count == 0 ? 0 : 1
        case 9: // Award details
            return profileDetail?.data?.awardsAndHonors?.count ?? 0
        case 10: // Technical Skills
            return profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.technical}).count == 0 ? 0 : 1
        case 11: // Technical Skills details
            return 1
        case 12: // Non-Technical Skills
            return profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.nonTechnical}).count == 0 ? 0 : 1
        case 13: // Non-Technical Skills details
            return 1
        case 14: // Tools
            return profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.tools.uppercased()}).count == 0 ? 0 : 1
        case 15: // Tools details
            return 1
        case 16: // Projects
            return profileDetail?.data?.projects?.count == 0 ? 0 : 1
        default: // Project details
            return profileDetail?.data?.projects?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as! ContactTableViewCell
            cell.configure(contactDetail: profileDetail?.data?.basicInfo)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.topConstraint.constant = 10
            cell.selectionStyle = .none
            cell.middleConstraint.constant = 0
            cell.lblPerviousCompany.isHidden = true
            cell.lblExperience.isHidden = true
            cell.lblDescriptionHeading.font = UIFont.getSemiBoldFont(size: 25)
            cell.configure(tags[indexPath.row], index: indexPath.section - 1)
            cell.updateUI(description: profileDetail?.data?.basicInfo)
            cell.delegate = self
            cell.readMoreButton.tag = indexPath.row
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.workExperience
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.lblDescriptionHeading.font = UIFont.getSemiBoldFont(size: 18)
            cell.topConstraint.constant = 10
            cell.lblPerviousCompany.isHidden = false
            cell.lblExperience.isHidden = false
            cell.configure(tags[indexPath.row + 1], index: indexPath.section - 2)
            cell.selectionStyle = .none
            if let experience = profileDetail?.data?.experiences?[indexPath.row] {
                cell.updateExperiencesUI(description: experience, tag: indexPath.row)
                cell.readMoreButton.tag = indexPath.row + 1
            }
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.education
            cell.topConstraint.constant = 10
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            cell.configure(educationdetail: profileDetail?.data?.academics?[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.certifications
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            cell.configureCertificates(certificatesDetail: profileDetail?.data?.certificates?[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.awards
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: AwardsHonorTVCell.className, for: indexPath) as! AwardsHonorTVCell
            cell.configureAwards(awardsData: profileDetail?.data?.awardsAndHonors?[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case 10:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.technicalSkills
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 11:
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            cell.configureSkills(skillsDetail: profileDetail?.data?.skills, skillType: StringConstants.technical)
            cell.selectionStyle = .none
            return cell
        case 12:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.nonTechnicalSkills
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 13:
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            cell.configureSkills(skillsDetail: profileDetail?.data?.skills, skillType: StringConstants.nonTechnical)
            cell.selectionStyle = .none
            return cell
        case 14:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.tools
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 15:
            let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className, for: indexPath) as! SkillsTableViewCell
            cell.configureSkills(skillsDetail: profileDetail?.data?.skills, skillType: StringConstants.tools.uppercased())
            cell.selectionStyle = .none
            return cell
        case 16:
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = StringConstants.projects
            cell.topConstraint.constant = 20
            cell.selectionStyle = .none
            return cell
        case 17:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectsTableViewCell.className, for: indexPath) as! ProjectsTableViewCell
            cell.configureProjects(data: profileDetail?.data?.projects?[indexPath.row])
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
