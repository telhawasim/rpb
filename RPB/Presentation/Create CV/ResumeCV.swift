//
//  ResumeCV.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class ResumeCV: BaseVC, UIGestureRecognizerDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: Variables
    var infoType: InfoType = .info
    var infoModel = [Section]()
    var skillsModel = [Section]()
    var experienceModel = [Section]()
    var selectedHeader = Int()
    var categoryTitle: [Category] = [.info, .experience, .skills, .academics]
    var category: Category = .skills
    var addExperiences = [ExperienceModel]()
    var addSkills = [String]()
    
    var infoTextFields = TextFieldModel.getInfoTextFields() {
        didSet {
            self.validation()
        }
    }
    
    var experienceTextFields = ExperienceModel.getExperienceTextFields() {
        didSet {
            self.experienceValidation()
        }
    }
    
    var academicsTextFields = AcademicsModel.getAcademicsTextFields() {
        didSet {
            self.academicsValidation()
        }
    }
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLabel()
        self.configureTableView()
        self.configureCollectionView()
        skillsModel = [(Section(section: "Soft Skills", rows: 1, expanded: true)),
                       (Section(section: "Hard Skills", rows: 1, expanded: false))]
        experienceModel = [Section(section: "Add Experience", rows: 1, expanded: true)]
        self.configureButtons()
        self.btnSave.isEnabled = false
        self.btnSave.backgroundColor = UIColor.systemGray
    }
    
    //MARK: Configure Labels
    func configureLabel() {
        self.lblTitle.font = UIFont.montserratMedium(24)
    }
    
    //MARK: Configure TableView
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(BasicInfoTVCell.className)
        self.tableView.register(EducationTVCell.className)
        self.tableView.register(SummaryTVCell.className)
        self.tableView.register(DobTVCell.className)
        self.tableView.register(TagsTableViewCell.className)
        self.tableView.register(ExperienceTVCell.className)
        self.tableView.register(AcademicsTVCell.className)
        self.tableView.register(AddSkillsTableViewCell.className)
        self.tableView.register(AddCertificatesTableViewCell.className)
        self.tableView.register(UINib(nibName: ResumeHeaderCell.className, bundle: nil), forHeaderFooterViewReuseIdentifier: ResumeHeaderCell.className)
    }
    
    //MARK: Configure CollectionView
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CategoryCVCell.className)
    }
    
    func removeCell(index: Int) {
        self.addExperiences.remove(at: index)
        self.tableView.reloadData()
    }
    
    func removeCellAcademics(index: Int) {
        self.academicsTextFields.remove(at: index)
        UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: { self.tableView.reloadData()
        }, completion: nil)

    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnPreview.borderWidth = 1
        self.btnPreview.borderColor = UIColor.customBlue
        self.btnPreview.titleLabel?.font = UIFont.montserratMedium(16)
        self.btnPreview.titleLabel?.textColor = UIColor.customBlue
        self.btnPreview.titleLabel?.text = "Previous"
        self.btnPreview.cornerRadiusButton(30)
        
        self.btnSave.backgroundColor = UIColor.customBlue
        self.btnSave.titleLabel?.font = UIFont.montserratMedium(16)
        self.btnSave.titleLabel?.textColor = UIColor.white
        self.btnSave.titleLabel?.text = "Save & Continue"
        self.btnSave.cornerRadiusButton(30)
        self.buttonView.addShadow(shadowOpacity: 0.5)
        
        if category == .info {
            btnPreview.isHidden = true
            self.validation()
        } else if category == .experience {
            btnPreview.isHidden = false
        } else if category == .skills {
            btnPreview.isHidden = false
        } else {
            if academicsTextFields.isEmpty {
                btnSave.isEnabled = true
                btnSave.backgroundColor = UIColor.customBlue
            }
            btnPreview.isHidden = false
        }
    }
    
    //MARK: Validation for Info textField's text is nil
    func validation() {
        var isAllPopulated = false
        
        for textField in self.infoTextFields {
            if textField.textValue.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        
        self.btnSave.isEnabled = isAllPopulated
        self.btnSave.backgroundColor = isAllPopulated ? UIColor.customBlue : UIColor.systemGray
    }
    
    //MARK: Validation for textField's text is nil
    func experienceValidation() {
        var isAllPopulated = false
        
        for textField in self.experienceTextFields {
            if textField.txtCompanyName.isEmpty || textField.txtStartDate.isEmpty || textField.txtEndDate.isEmpty || textField.txtView.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        
        self.btnSave.isEnabled = isAllPopulated
        self.btnSave.backgroundColor = isAllPopulated ? UIColor.customBlue : UIColor.systemGray
    }
    
    //MARK: Validation for Academics textField's text is nil
    func academicsValidation() {
        var isAllPopulated = false
        
        for textField in self.academicsTextFields {
            if textField.txtDegree.isEmpty || textField.txtInstitute.isEmpty || textField.txtStartsFrom.isEmpty || textField.txtEndsTo.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        
        self.btnSave.isEnabled = isAllPopulated
        self.btnSave.backgroundColor = isAllPopulated ? UIColor.customBlue : UIColor.systemGray
    }
    
    //MARK: Info Tab TextField Validatiom
    func infoTabTextFieldValidation() -> Bool {
        let email = infoTextFields[2].textValue
        let phone = infoTextFields[3].textValue
        var errorMessage: String?
        
        if !email.isEmailValid() {
            errorMessage = "Email address must be valid"
        } else if phone.count < 11 {
            errorMessage = "Phone number must be 11 digits long"
        }
        
        if let errorMsg = errorMessage {
            self.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    func selectAndUpdateCV(indexPath: IndexPath) {
        let index = categoryTitle.firstIndex(of: self.category) ?? 0
        let previousIndex = IndexPath(item: index, section: 0)
        self.category = self.categoryTitle[indexPath.item]
        self.collectionView.reloadItems(at: [previousIndex, indexPath])
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func updateTabelView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: { self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                self.configureButtons()
            }, completion: nil)
        }
    }
    
    //MARK: Go back Button Pressed
    @IBAction func btnGoBack(_ sender: Any) {
        PopupView.shared.presentPopup(self, popupType: .discardInformation) { value in
            if (value != nil) {
                self.infoTextFields = []
                self.goBack()
            }
        }
    }
    
    //MARK: Save Button Pressed
    @IBAction func btnSavePressed(_ sender: Any) {
        switch category {
        case .info:
            if self.btnSave.isEnabled {
                if infoTabTextFieldValidation() {
                    let index = IndexPath(item: 1, section: 0)
                    self.selectAndUpdateCV(indexPath: index)
                    self.updateTabelView()
                }
            }
        case .experience:
            if self.btnSave.isEnabled {
                let index = IndexPath(item: 1, section: 0)
                self.selectAndUpdateCV(indexPath: index)
                self.updateTabelView()
            }
        case .skills:
            if self.btnSave.isEnabled {
                let index = IndexPath(item: 1, section: 0)
                self.selectAndUpdateCV(indexPath: index)
                self.updateTabelView()
            }
        case .academics:
            if self.btnSave.isEnabled {
                self.goToPreviewCV()
            }
        }
    }
    
    //MARK: Previous Button Pressed
    @IBAction func btnPreviousPressed(_ sender: Any) {
        switch category {
        case .info:
            break
        case .experience:
            let index = IndexPath(item: 0, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTabelView()
        case .skills:
            print("Skills")
            let index = IndexPath(item: 1, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTabelView()
        case .academics:
            print("Skills")
            let index = IndexPath(item: 2, section: 0)
            self.selectAndUpdateCV(indexPath: index)
//            self.updateTabelView()
        }
    }
}

//MARK: CollectionView Methods
extension ResumeCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as! CategoryCVCell
        let isSelected = self.categoryTitle[indexPath.row] == category
        cell.configure(isSelected, title: categoryTitle[indexPath.row].rawValue.capitalized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.0, height: 42.0)
    }
}

//MARK: TableView Methods
extension ResumeCV: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch category {
        case .info:
            return 2
        case .experience:
            return 2
        case .skills:
            return 2
        case .academics:
            return 1
        }
    }
    
    //MARK: Number of rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .info:
            return section == 0 ? (infoTextFields.count - 1) : 1
        case .experience:
            if section == 0 {
                return 1
            } else {
                return addExperiences.count
            }
        case .skills:
            if section == 0 {
                return 1
            } else {
                return 1
            }
        case .academics:
            return academicsTextFields.count
        }
    }
    
    //MARK: View for Header in Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResumeHeaderCell.className) as! ResumeHeaderCell
        
        switch category {
        case .info:
            headerView.lblHeading.text = (section == 0) ? "Basic Info" : "Summary"
            headerView.btnaddMoreCell.isHidden = true
        case .experience:
            if section == 0 {
                headerView.lblHeading.text = "Current Experiernce"
                headerView.btnaddMoreCell.isHidden = true
            } else {
                headerView.lblHeading.text = "Past Experiernce"
                headerView.btnaddMoreCell.isHidden = false
                
                headerView.addMore = {
                    self.addExperiences.append(ExperienceModel())
                    self.tableView.reloadData()
                }
            }
        case .skills:
            if section == 0 {
                headerView.lblHeading.text = "Add Skills"
            } else {
                headerView.lblHeading.text = "Add Certificates"
                
                headerView.addMore = {
                    self.addExperiences.append(ExperienceModel())
                    self.tableView.reloadData()
                }
            }

        case .academics:
            headerView.lblHeading.text = "Add Qualifications"
            headerView.addMore = {
                self.academicsTextFields.append(AcademicsModel())
                UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: self.academicsTextFields.count-1, section: 0), at: .top, animated: false)
                }, completion: nil)
            }
        default:
            break
        }
        return headerView
    }
    
    //MARK: Height for Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    //MARK: Cell for Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch category {
        case .info:
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
                cell.configure(infoTextFields[indexPath.row])
                
                cell.textDidChange = { [weak self] (txtField) in
                    self?.infoTextFields[indexPath.row].textValue = txtField.text ?? ""
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTVCell", for: indexPath) as! SummaryTVCell
                cell.textDidChange = { [weak self] (txtView) in
                    guard let self = self else {return}
                    self.infoTextFields[self.infoTextFields.count - 1].textValue = txtView.text ?? ""
                }
                return cell
            }
            
        case .experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTVCell", for: indexPath) as! ExperienceTVCell
            
            if indexPath.section == 0 {
                cell.deleteStack.isHidden = true
                cell.endDateStack.isHidden = true
                
            } else if indexPath.section == 1 {
                cell.deleteStack.isHidden = false
                cell.endDateStack.isHidden = false
                cell.lblCount.text = "\(indexPath.row + 1)"
            }
            
            cell.deleteCell = { [weak self] in
                guard let self = self else {return}
                if self.addExperiences.count > 0 {
                    self.removeCell(index: indexPath.row)
                }
            }
            
            cell.textComapnyDidChange = { [weak self] (txtField) in
                self?.experienceTextFields[indexPath.row].txtCompanyName = txtField.text ?? ""
            }
            
            cell.textStartDateDidChange = { [weak self] (txtField) in
                self?.experienceTextFields[indexPath.row].txtStartDate = txtField.text ?? ""
            }
            
            cell.textEndDateDidChange = { [weak self] (txtField) in
                self?.experienceTextFields[indexPath.row].txtEndDate = txtField.text ?? ""
            }
            
            cell.textViewDidChange = { [weak self] (txtView) in
                guard let self = self else {return}
                self.experienceTextFields[indexPath.row].txtView = txtView.text ?? ""
            }
            //cell.configure(experienceTextFields[indexPath.row])
            return cell
            
        case .skills:
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddSkillsTableViewCell", for: indexPath) as! AddSkillsTableViewCell
                return cell

            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCertificatesTableViewCell", for: indexPath) as! AddCertificatesTableViewCell
                return cell
            }

//            cell.deleteCell = { [weak self] in
//                guard let self = self else {return}
//                if self.addExperiences.count > 0 {
//                    self.removeCell(index: indexPath.row)
//                }
//            }
//
//            cell.textComapnyDidChange = { [weak self] (txtField) in
//                self?.experienceTextFields[indexPath.row].txtCompanyName = txtField.text ?? ""
//            }
//
//            cell.textStartDateDidChange = { [weak self] (txtField) in
//                self?.experienceTextFields[indexPath.row].txtStartDate = txtField.text ?? ""
//            }
//
//            cell.textEndDateDidChange = { [weak self] (txtField) in
//                self?.experienceTextFields[indexPath.row].txtEndDate = txtField.text ?? ""
//            }
//
//            cell.textViewDidChange = { [weak self] (txtView) in
//                guard let self = self else {return}
//                self.experienceTextFields[indexPath.row].txtView = txtView.text ?? ""
//            }
            //cell.configure(experienceTextFields[indexPath.row])
            
        case .academics:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcademicsTVCell", for: indexPath) as! AcademicsTVCell
            cell.lblCount.text = "\(indexPath.row + 1)"
            cell.delegate = self
            cell.configure(data: academicsTextFields[indexPath.row])
            
            cell.textDegreeDidChange = { [weak self] (txtField) in
                self?.academicsTextFields[indexPath.row].txtDegree = txtField.text ?? ""
            }
            
            cell.textInstituteDidChange = { [weak self] (txtField) in
                self?.academicsTextFields[indexPath.row].txtInstitute = txtField.text ?? ""
            }
            
            cell.textStartDateDidChange = { [weak self] (txtField) in
                self?.academicsTextFields[indexPath.row].txtStartsFrom = txtField.text ?? ""
            }
            
            cell.textEndDateDidChange = { [weak self] (txtField) in
                guard let self = self else {return}
                self.academicsTextFields[indexPath.row].txtEndsTo = txtField.text ?? ""
            }
            cell.deleteCell = { [weak self] in
                guard let self = self else {return}
                if self.academicsTextFields.count > 0 {
                    self.removeCellAcademics(index: indexPath.row)
                }
            }
            return cell
        }
    }
}

//MARK: ExperienceTVCell Delegate
extension ResumeCV: ExperienceTVCellProtocol, AddCertificatesTVCellProtocol {
    func dismissPicker() {
        self.view.endEditing(true)
    }
    
    func adjustTextViewHeight() {
        self.view.layoutIfNeeded()
    }
    
    func showAlert(errorMessage: String) {
        self.alert(message: errorMessage)
    }
}


