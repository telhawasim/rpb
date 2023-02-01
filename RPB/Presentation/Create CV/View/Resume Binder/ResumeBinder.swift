//
//  ResumeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit

class ResumeBinder: NSObject {
    
    //MARK: Variables
    weak var lblTitle: UILabel?
    weak var collectionView: UICollectionView?
    weak var tableView: UITableView?
    weak var buttonView: UIView?
    weak var btnPreview: UIButton?
    weak var btnSave: UIButton?
    weak var viewController: UIViewController?
    
    init(lblTitle: UILabel, collectionView: UICollectionView, tableView: UITableView, buttonView: UIView, btnPreview: UIButton, btnSave: UIButton, viewController: UIViewController) {
        self.lblTitle = lblTitle
        self.collectionView = collectionView
        self.tableView = tableView
        self.buttonView = buttonView
        self.btnPreview = btnPreview
        self.btnSave = btnSave
        self.viewController = viewController
    }
    
    var categoryTitle: [Category] = [.info, .experience, .skills, .academics]
    var category: Category = .info
    var isAllPopulated = false
    
    var infoTextFields = TextFieldModel.getInfoTextFields() {
        didSet {
            self.infoValidation()
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
    
    var skillsTextFields = SkillsModel.getSkillsData() {
        didSet {
            if skillsValidation() {
                self.certificatesValidation()
            }
        }
    }
    
    var certificatesTextField = AcademicsModel.getAcademicsTextFields() {
        didSet {
            if skillsValidation() {
                self.certificatesValidation()
            }
        }
    }
    
    //MARK: Configure Labels
    func configureLabel() {
        self.lblTitle?.font = UIFont.getMediumFont(size: 24)
    }
    
    //MARK: Configure TableView
    func configureTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(BasicInfoTVCell.className)
        self.tableView?.register(SummaryTVCell.className)
        self.tableView?.register(TagsTableViewCell.className)
        self.tableView?.register(ExperienceTVCell.className)
        self.tableView?.register(AcademicsTVCell.className)
        self.tableView?.register(AddSkillsTableViewCell.className)
        self.tableView?.register(AddCertificatesTableViewCell.className)
        self.tableView?.register(UINib(nibName: ResumeHeaderCell.className, bundle: nil), forHeaderFooterViewReuseIdentifier: ResumeHeaderCell.className)
    }
    
    //MARK: Configure CollectionView
    func configureCollectionView() {
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(CategoryCVCell.className)
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnPreview?.borderWidth = 1
        self.btnPreview?.borderColor = UIColor.customBlue
        self.btnPreview?.titleLabel?.font = UIFont.getMediumFont()
        self.btnPreview?.titleLabel?.textColor = UIColor.customBlue
        self.btnPreview?.cornerRadiusButton(30)
        
        self.btnSave?.backgroundColor = UIColor.customBlue
        self.btnSave?.titleLabel?.font = UIFont.getMediumFont()
        self.btnSave?.titleLabel?.textColor = UIColor.white
        self.btnSave?.cornerRadiusButton(30)
        self.buttonView?.addShadow(shadowOpacity: 0.5)
        
        if category == .info {
            btnPreview?.isHidden = true
            if infoTextFields.isEmpty {
                btnSave?.isEnabled = false
                btnSave?.backgroundColor = UIColor.systemGray
            } else {
                btnSave?.isEnabled = true
                btnSave?.backgroundColor = UIColor.customBlue
            }
        } else if category == .experience {
            btnPreview?.isHidden = false
            experienceValidation()
        } else if category == .skills {
            btnPreview?.isHidden = false
            skillsValidation()
        } else {
            academicsValidation()
            if academicsTextFields.isEmpty {
                btnSave?.isEnabled = false
                btnSave?.backgroundColor = UIColor.systemGray
            }
            btnPreview?.isHidden = false
        }
    }
    
    func removeCell(index: Int, cellType: CellType, section: Int) {
        switch cellType {
        case .experince:
            self.experienceTextFields.remove(at: index)
        case .skills:
            self.skillsTextFields.remove(at: index)
        case .certificates:
            self.certificatesTextField.remove(at: index)
        case .academic:
            self.academicsTextFields.remove(at: index)
        }
        UIView.transition(with: self.tableView ?? UITableView(), duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
        }, completion: nil)
    }
    
    func setupButton(isPopulated: Bool) {
        self.btnSave?.isEnabled = isPopulated
        self.btnSave?.backgroundColor = isPopulated ? UIColor.customBlue : UIColor.systemGray
    }
    
    //MARK: Validation for Info textField's text is nil
    func infoValidation() {
        for textField in self.infoTextFields {
            if textField.textValue.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for textField's text is nil
    func experienceValidation() {
        
        for textField in self.experienceTextFields {
            if textField.txtCompanyName.isEmpty || textField.txtStartDate.isEmpty || textField.txtEndDate.isEmpty || textField.txtView.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for Academics textField's text is nil
    func academicsValidation() {
        
        for textField in self.academicsTextFields {
            if textField.txtDegree.isEmpty || textField.txtInstitute.isEmpty || textField.txtStartsFrom.isEmpty || textField.txtEndsTo.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for Skills is nil
    @discardableResult func skillsValidation() -> Bool {
        isAllPopulated = true
        for textField in self.skillsTextFields {
            if textField.txtSkills.isEmpty || textField.txtPercentage.isEmpty || textField.txtPercentage == "0%" || textField.slider == 0.0 {
                isAllPopulated = false
                break
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
        return isAllPopulated
    }
    
    //MARK: Validation for Certificates is nil
    func certificatesValidation() {
        if !certificatesTextField.isEmpty {
            for textField in self.certificatesTextField {
                if textField.txtDegree.isEmpty || textField.txtInstitute.isEmpty || textField.txtStartsFrom.isEmpty || textField.txtEndsTo.isEmpty {
                    isAllPopulated = false
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
        
    }
    
    //MARK: Info Tab TextField Validatiom
    func infoTabTextFieldValidation() -> Bool {
        let email = infoTextFields[2].textValue
        let phone = infoTextFields[3].textValue
        var errorMessage: String?
        
        if !email.isEmailValid() {
            errorMessage = Localization.Login.kEmailInvalidError
        } else if phone.count < 11 {
            errorMessage = Localization.AddEmployee.kPhoneLengthError
        }
        
        if let errorMsg = errorMessage {
            AlertHandler.shared.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    func selectAndUpdateCV(indexPath: IndexPath) {
        let index = categoryTitle.firstIndex(of: self.category) ?? 0
        let previousIndex = IndexPath(item: index, section: 0)
        self.category = self.categoryTitle[indexPath.item]
        self.collectionView?.reloadItems(at: [previousIndex, indexPath])
        self.collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func updateTableView() {
        UIView.transition(with: self.tableView ?? UITableView(), duration: 0.3, options: .transitionCrossDissolve, animations: { self.tableView?.reloadData()
            let targetRowIndexPath = IndexPath(row: 0, section: 0)
            if let tableView = self.tableView {
                if tableView.indexPathExists(indexPath: targetRowIndexPath) {
                    tableView.scrollToRow(at: targetRowIndexPath, at: .top, animated: true)
                }
            }
            self.configureButtons()
        }, completion: nil)
    }
    
    func saveButtonPressed() {
        guard let btnSave = self.btnSave else {return}
        switch category {
        case .info:
            if btnSave.isEnabled {
                if infoTabTextFieldValidation() {
                    let index = IndexPath(item: 1, section: 0)
                    self.selectAndUpdateCV(indexPath: index)
                    self.updateTableView()
                }
            }
        case .experience:
            if btnSave.isEnabled {
                let index = IndexPath(item: 2, section: 0)
                self.selectAndUpdateCV(indexPath: index)
                self.updateTableView()
            }
        case .skills:
            if btnSave.isEnabled {
                let index = IndexPath(item: 3, section: 0)
                self.selectAndUpdateCV(indexPath: index)
                self.updateTableView()
            }
        case .academics:
            if btnSave.isEnabled {
                let tabbarVC  = UIStoryboard.getVC(from: .main, CVPreviewVC.className)
                self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
            }
        }
    }
    
    func previousButtonPressed() {
        switch category {
        case .info:
            break
        case .experience:
            let index = IndexPath(item: 0, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        case .skills:
            let index = IndexPath(item: 1, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        case .academics:
            let index = IndexPath(item: 2, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        }
    }
    
    func goBackPressed() {
        PopupView.shared.presentPopup(self.viewController ?? UIViewController(), popupType: .discardInformation) { value in
            if (value != nil) {
                self.infoTextFields = []
                self.experienceTextFields = []
                self.skillsTextFields = []
                self.academicsTextFields = []
                self.viewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

//MARK: CollectionView Methods
extension ResumeBinder: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVCell.className, for: indexPath) as! CategoryCVCell
        let isSelected = self.categoryTitle[indexPath.row] == category
        cell.configure(isSelected, title: categoryTitle[indexPath.row].rawValue.capitalized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.0, height: 42.0)
    }
}

//MARK: TableView Methods
extension ResumeBinder: UITableViewDelegate, UITableViewDataSource {
    
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
            return section == 0 ? (experienceTextFields.startIndex + 1) : (experienceTextFields.count - 1)
        case .skills:
            return section == 0 ? (skillsTextFields.count) : certificatesTextField.count
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
                    self.experienceTextFields.append(ExperienceModel())
                    UIView.transition(with: self.tableView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.tableView?.reloadData()
                        //                        self.tableView.scrollToRow(at: IndexPath(row: self.experienceTextFields.count-1, section: 1), at: .top, animated: false)
                    }, completion: nil)
                }
            }
        case .skills:
            if section == 0 {
                headerView.btnaddMoreCell.isHidden = false
                headerView.lblHeading.text = "Add Skills"
                headerView.addMore = {
                    self.skillsTextFields.append(SkillsModel())
                    
                    UIView.transition(with: self.tableView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.tableView?.reloadData()
                        self.tableView?.scrollToRow(at: IndexPath(row: self.skillsTextFields.count-1, section: 0), at: .top, animated: false)
                    }, completion: nil)
                }
            } else {
                headerView.btnaddMoreCell.isHidden = false
                headerView.lblHeading.text = "Add Certificates"
                headerView.addMore = {
                    self.certificatesTextField.append(AcademicsModel())
                    UIView.transition(with: self.tableView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.tableView?.reloadData()
                        self.tableView?.scrollToRow(at: IndexPath(row: self.certificatesTextField.count-1, section: 1), at: .top, animated: false)
                    }, completion: nil)
                }
            }
            
        case .academics:
            headerView.lblHeading.text = "Add Qualifications"
            headerView.addMore = {
                self.academicsTextFields.append(AcademicsModel())
                UIView.transition(with: self.tableView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.tableView?.reloadData()
                    self.tableView?.scrollToRow(at: IndexPath(row: self.academicsTextFields.count-1, section: 0), at: .top, animated: false)
                }, completion: nil)
            }
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
                let cell = tableView.dequeueReusableCell(withIdentifier: BasicInfoTVCell.className, for: indexPath) as! BasicInfoTVCell
                cell.configure(infoTextFields[indexPath.row])
                
                cell.textDidChange = { [weak self] (txtField) in
                    self?.infoTextFields[indexPath.row].textValue = txtField.text ?? ""
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTVCell.className, for: indexPath) as! SummaryTVCell
                cell.textDidChange = { [weak self] (txtView) in
                    guard let self = self else {return}
                    self.infoTextFields[self.infoTextFields.count - 1].textValue = txtView.text ?? ""
                }
                
                return cell
            }
            
        case .experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceTVCell.className, for: indexPath) as! ExperienceTVCell
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.txtCompany.isUserInteractionEnabled = false
                    cell.configure(experienceTextFields[indexPath.row])
                }
                cell.deleteStack.isHidden = true
                cell.endDateStack.isHidden = true
                
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
                
            } else {
                cell.txtCompany.isUserInteractionEnabled = true
                cell.txtEndDate.isUserInteractionEnabled = false
                cell.configure(experienceTextFields[indexPath.row + 1])
                cell.deleteStack.isHidden = false
                cell.endDateStack.isHidden = false
                cell.lblCount.text = "\(indexPath.row + 1)"
                
                cell.textComapnyDidChange = { [weak self] (txtField) in
                    self?.experienceTextFields[indexPath.row+1].txtCompanyName = txtField.text ?? ""
                }
                
                cell.textStartDateDidChange = { [weak self] (txtField) in
                    self?.experienceTextFields[indexPath.row+1].txtStartDate = txtField.text ?? ""
                }
                
                cell.textEndDateDidChange = { [weak self] (txtField) in
                    self?.experienceTextFields[indexPath.row+1].txtEndDate = txtField.text ?? ""
                }
                
                cell.textViewDidChange = { [weak self] (txtView) in
                    guard let self = self else {return}
                    self.experienceTextFields[indexPath.row+1].txtView = txtView.text ?? ""
                }
            }
            
            cell.deleteCell = { [weak self] in
                guard let self = self else {return}
                if self.experienceTextFields.count > 0 {
                    self.removeCell(index: indexPath.row + 1, cellType: .experince, section: indexPath.section)
                }
                self.experienceValidation()
            }
            
            
            return cell
            
        case .skills:
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddSkillsTableViewCell.className, for: indexPath) as! AddSkillsTableViewCell
                cell.lblcount.text = "\(indexPath.row + 1)"
                
                cell.configure(data: skillsTextFields[indexPath.row])
                
                cell.sliderPercentage = { [weak self] (label) in
                    guard let self = self else {return}
                    self.skillsTextFields[indexPath.row].txtPercentage = label.text ?? ""
                }
                
                cell.sliderData = { [weak self] (slider) in
                    guard let self = self else {return}
                    self.skillsTextFields[indexPath.row].slider = slider.value
                }
                
                cell.textSkillsDidChange = { [weak self] (txtField) in
                    guard let self = self else {return}
                    self.skillsTextFields[indexPath.row].txtSkills = txtField.text ?? ""
                }
                
                cell.deleteCell = { [weak self] in
                    guard let self = self else {return}
                    if self.skillsTextFields.count > 1 {
                        self.removeCell(index: indexPath.row, cellType: .skills, section: indexPath.section)
                    }
                }
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddCertificatesTableViewCell.className, for: indexPath) as! AddCertificatesTableViewCell
                
                cell.lblCount.text = "\(indexPath.row + 1)"
                cell.configure(data: certificatesTextField[indexPath.row])
                cell.txtEndDate.isUserInteractionEnabled = false
                
                cell.deleteCell = { [weak self] in
                    guard let self = self else {return}
                    if self.certificatesTextField.count > 0 {
                        self.removeCell(index: indexPath.row, cellType: .certificates, section: indexPath.section)
                    }
                }
                
                cell.textCourseDidChange = { [weak self] (txtField) in
                    self?.certificatesTextField[indexPath.row].txtDegree = txtField.text ?? ""
                }
                
                cell.textInstituteDidChange = { [weak self] (txtField) in
                    self?.certificatesTextField[indexPath.row].txtInstitute = txtField.text ?? ""
                }
                
                cell.textStartDateDidChange = { [weak self] (txtField) in
                    self?.certificatesTextField[indexPath.row].txtStartsFrom = txtField.text ?? ""
                }
                
                cell.textEndDateDidChange = { [weak self] (txtField) in
                    self?.certificatesTextField[indexPath.row].txtEndsTo = txtField.text ?? ""
                }
                return cell
            }
        case .academics:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AcademicsTVCell.className, for: indexPath) as! AcademicsTVCell
            cell.lblCount.text = "\(indexPath.row + 1)"
            cell.configure(data: academicsTextFields[indexPath.row])
            cell.txtEndsTo.isUserInteractionEnabled = false
            
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
                    self.removeCell(index: indexPath.row, cellType: .academic, section: indexPath.section)
                }
            }
            return cell
        }
    }
}
