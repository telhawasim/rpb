//
//  CVPreviewVC.swift
//  RPB
//
//  Created by Bilal Nisar on 27/12/2022.
//

import UIKit

class CVPreviewVC: BaseVC, UpdateCustomCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var lblViewProfile: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.updateTableView(willExpand: false)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func btnDownloadTapped(_ sender: Any) {
        goToDownloadSection()
    }
}

// MARK: TableView Methods
extension CVPreviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as! ContactTableViewCell
            return cell
                    
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.middleConstraint.constant = 5
            cell.lblPerviousCompany.isHidden = true
            cell.lblDescriptionHeading.text = "Summary"
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.topConstraint.constant = 10
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.lblDescriptionHeading.text = "IOS Developer"
            cell.lblPerviousCompany.text = "Synavos"
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.topConstraint.constant = 0
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.lblDescriptionHeading.text = "IOS Developer"
            cell.lblPerviousCompany.text = "i2c"
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionTableViewCell.className, for: indexPath) as! EventDescriptionTableViewCell
            cell.topConstraint.constant = 0
            cell.lblDescriptionHeading.font = UIFont.getRegularFont()
            cell.lblDescriptionHeading.text = "IOS Developer"
            cell.lblPerviousCompany.text = "Pure Logics"
            cell.updateUI()
            cell.delegate = self
            return cell
        } else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTextTableViewCell.className, for: indexPath) as! EducationTextTableViewCell
            cell.lblEducation.text = "Education"
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableViewCell.className, for: indexPath) as! EducationTableViewCell
            return cell
        }
    }
}

extension CVPreviewVC {
    //MARK: Register Cell
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventDescriptionTableViewCell.className)
        tableView.register(EducationTableViewCell.className)
        tableView.register(SkillsTableViewCell.className)
        tableView.register(ExperienceTableViewCell.className)
        tableView.register(ContactTableViewCell.className)
        tableView.register(EducationTextTableViewCell.className)

        self.configureFonts()
        self.configureButtons()
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnEdit.isCircularButton()
        self.btnEdit.backgroundColor = UIColor.blueF1F1FF
        self.btnDownload.backgroundColor = UIColor.blueF1F1FF
        self.btnDownload.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblViewProfile.font = UIFont.getMediumFont(size: 22)
        self.lblName.font = UIFont.getSemiBoldFont(size: 24)
    }
    
    func updateTableView(willExpand: Bool) {
        self.tableView.reloadData()
        if (!willExpand) {
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: false)
        }
    }
}
