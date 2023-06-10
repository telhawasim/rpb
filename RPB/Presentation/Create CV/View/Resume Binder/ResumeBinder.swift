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
    weak var startDatePicker: MonthYearWheelPicker?
    weak var endDatePicker: MonthYearWheelPicker?
    weak var startDateViewPicker: UIView?
    weak var endDateViewPicker: UIView?
    weak var superView: UIView?
    weak var overlayView: UIView?
    
    init(lblTitle: UILabel, collectionView: UICollectionView, tableView: UITableView, buttonView: UIView, btnPreview: UIButton, btnSave: UIButton, viewController: UIViewController, startDatePicker: MonthYearWheelPicker, endDatePicker: MonthYearWheelPicker, startDateViewPicker: UIView, endDateViewPicker: UIView, superView: UIView, overlayView: UIView, buttonPressed: @escaping (UIButton) -> Void) {
        self.lblTitle = lblTitle
        self.collectionView = collectionView
        self.tableView = tableView
        self.buttonView = buttonView
        self.btnPreview = btnPreview
        self.btnSave = btnSave
        self.viewController = viewController
        self.startDatePicker = startDatePicker
        self.endDatePicker = endDatePicker
        self.startDateViewPicker = startDateViewPicker
        self.endDateViewPicker = endDateViewPicker
        self.superView = superView
        self.overlayView = overlayView
        self.buttonPressed = buttonPressed
    }
    
    var categoryTitle: [Category] = [.info, .experience, .academics, .skills, .projects]
    var category: Category = .info
    var isCertificates: Bool = false
    var isAllPopulated = false
    var pickerIndex = 0
    var designations: [Departments]?
    var designationID: String?
    var buttonPressed: ((UIButton) -> Void)
    
    var infoTextFields = TextFieldModel.getInfoTextFields() {
        didSet {
            self.validationFields(for: .info)
        }
    }
    
    var experienceTextFields = ExperienceModel.getExperienceTextFields() {
        didSet {
            self.validationFields(for: .experience)
        }
    }
    
    var academicsTextFields = AcademicsModel.getAcademicsTextFields() {
        didSet {
            self.validationFields(for: .academics)
        }
    }
    
    var technicalSkillsTextField = SkillsModel.getTechnicalSkillsData() {
        didSet {
            self.validationFields(for: .technicalSkills)
        }
    }
    
    var nonTechnicalSkillsTextField = SkillsModel.getNonTechnicalSkills() {
        didSet {
            self.validationFields(for: .nonTechnicalSkills)
        }
    }
    
    var toolsTextField = SkillsModel.getTools() {
        didSet {
            self.validationFields(for: .tools)
        }
    }
    
    var certificatesTextField = CertificatesModel.getCertificateTextFields() {
        didSet {
            self.validationFields(for: .certificates)
        }
    }
    
    var awardsTextFields = AwardsModel.getAwardsTextFields() {
        didSet {
            self.validationFields(for: .awards)
        }
    }
    
    var projectsTextFields = ProjectsModel.getProjectsTextFields() {
        didSet {
            self.validationFields(for: .projects)
        }
    }
    
    func validationFields(for property: ValidationType) {
        switch property {
        case .info:
            self.infoValidation()
        case .experience:
            self.experienceValidation()
        case .technicalSkills:
            if nonTechnicalSkillsValidation() && toolsValidation() {
                self.technicalSkillsValidation()
            }
        case .nonTechnicalSkills:
            if technicalSkillsValidation() && toolsValidation() {
                self.nonTechnicalSkillsValidation()
            }
        case .tools:
            if technicalSkillsValidation() && nonTechnicalSkillsValidation() {
                self.toolsValidation()
            }
        case .certificates:
            if self.academicsValidation() {
                self.certificatesValidation()
            }
        case .academics:
            self.academicsValidation()
        case .awards:
            if self.academicsValidation() {
                self.awardsValidation()
            }
        case .projects:
            self.projectsValidation()
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
        self.tableView?.register(AddMoreTVCell.className)
        self.tableView?.register(TagsTableViewCell.className)
        self.tableView?.register(ExperienceTVCell.className)
        self.tableView?.register(AcademicsTVCell.className)
        self.tableView?.register(AwardsTVCell.className)
        self.tableView?.register(AddSkillsTableViewCell.className)
        self.tableView?.register(AddCertificatesTableViewCell.className)
        self.tableView?.register(AddProjectsTVCell.className)
        self.tableView?.register(EmptyTVCell.className)
        self.tableView?.register(PhoneNumberTVCell.className)
        self.tableView?.registerHeaderFooter(ResumeHeaderCell.className)
    }
    
    //MARK: Configure CollectionView
    func configureCollectionView() {
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(CategoryCVCell.className)
    }
    
    func configurePicker() {
        let maximumDateForStartPicker = Date()
        let minimumDateForStartPicker = Calendar.current.date(byAdding: .year, value: -20, to: Date())
        self.startDatePicker?.maximumDate = maximumDateForStartPicker
        self.startDatePicker?.minimumDate = minimumDateForStartPicker ?? Date()
        
    }
    
    @objc func monthYearWheelPickerDidChange(_ picker: MonthYearWheelPicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.MMM_yyyy
        
        switch picker {
        case startDatePicker:
            if let date = startDatePicker?.date.toLocalTime() {
                let formattedDate = dateFormatter.string(from: date)
                switch category {
                case .info:
                    break
                case .experience:
                    self.experienceTextFields[pickerIndex].startsFrom = formattedDate
                case .skills:
                    break
                case .academics:
                    if isCertificates {
                        self.certificatesTextField[pickerIndex].certStartsFrom = formattedDate
                    } else {
                        self.academicsTextFields[pickerIndex].academicStartsFrom = formattedDate
                    }
                case .projects:
                    break
                }
                self.tableView?.reloadData()
            }
        case endDatePicker:
            if let date = endDatePicker?.date.toLocalTime() {
                let formattedDate = dateFormatter.string(from: date)
                switch category {
                case .info:
                    break
                case .experience:
                    self.experienceTextFields[pickerIndex].endsTo = formattedDate
                case .skills:
                    break
                case .academics:
                    if isCertificates {
                        self.certificatesTextField[pickerIndex].certEndsTo = formattedDate
                    } else {
                        self.academicsTextFields[pickerIndex].academicEndsTo = formattedDate
                    }
                case .projects:
                    break
                }
                self.tableView?.reloadData()
            }
        default:
            return
        }
    }
    
    func doneButtonPressed(_ button: UIButton) {
        
        self.overlayView?.isUserInteractionEnabled = false
        
        switch button.tag {
        case 0:
            self.startDatePicker?.addTarget(self, action: #selector(monthYearWheelPickerDidChange(_:)), for: .valueChanged)
            UIView.transition(with: self.startDateViewPicker ?? UIView(), duration: 0.3, options: .transitionCrossDissolve) {
                self.superView?.layoutIfNeeded()
                if let startDatePicker = self.startDatePicker {
                    self.monthYearWheelPickerDidChange(startDatePicker)
                    
                }
            }
            self.startDateViewPicker?.isHidden = true
            self.startDatePicker?.isHidden = true
            switch category {
            case .info:
                break
            case .experience:
                if pickerIndex != 0 {
                    self.experienceTextFields[pickerIndex].endsTo = ""
                }
            case .skills:
                self.certificatesTextField[pickerIndex].certEndsTo = ""
            case .academics:
                if isCertificates {
                    self.certificatesTextField[pickerIndex].certEndsTo = ""
                } else {
                    self.academicsTextFields[pickerIndex].academicEndsTo = ""
                }
            case .projects:
                break
            }
            self.endDatePicker?.minimumDate = startDatePicker?.date ?? Date()
            self.endDatePicker?.maximumDate = Date()
            self.endDatePicker?.reloadAllComponents()
            
        case 1:
            self.endDateViewPicker?.isHidden = true
            self.endDatePicker?.isHidden = true
            UIView.transition(with: self.endDateViewPicker ?? UIView(), duration: 0.3, options: .transitionCrossDissolve) {
                self.superView?.layoutIfNeeded()
                if let endDatePicker = self.endDatePicker {
                    self.monthYearWheelPickerDidChange(endDatePicker)
                }
            }
            self.endDatePicker?.isHidden = true
            self.endDateViewPicker?.isHidden = true
            
        default:
            return
        }
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnPreview?.borderWidth = 1
        self.btnPreview?.borderColor = UIColor.appColor
        self.btnPreview?.titleLabel?.font = UIFont.getMediumFont()
        self.btnPreview?.titleLabel?.textColor = UIColor.appColor
        self.btnPreview?.cornerRadiusButton(30)
        
        self.btnSave?.backgroundColor = UIColor.appColor
        self.btnSave?.titleLabel?.font = UIFont.getMediumFont()
        self.btnSave?.titleLabel?.textColor = UIColor.white
        self.btnSave?.cornerRadiusButton(30)
        self.buttonView?.addShadow(shadowOpacity: 0.5)
        
        if category == .info {
            btnPreview?.isHidden = true
            infoValidation()
        } else if category == .experience {
            btnPreview?.isHidden = false
            experienceValidation()
        } else if category == .skills {
            btnPreview?.isHidden = false
            technicalSkillsValidation()
            nonTechnicalSkillsValidation()
            toolsValidation()
        } else if category == .academics {
            academicsValidation()
            if academicsTextFields.isEmpty {
                btnSave?.isEnabled = false
                btnSave?.backgroundColor = UIColor.systemGray
            }
            btnPreview?.isHidden = false
        } else {
            projectsValidation()
        }
    }
    
    func removeCell(index: Int, cellType: CellType, section: Int) {
        switch cellType {
        case .experince:
            self.experienceTextFields.remove(at: index)
        case .skills:
            if section == 0 {
                self.technicalSkillsTextField.remove(at: index)
            } else if section == 1 {
                self.nonTechnicalSkillsTextField.remove(at: index)
            } else {
                self.toolsTextField.remove(at: index)
            }
        case .certificates:
            self.certificatesTextField.remove(at: index)
        case .academic:
            self.academicsTextFields.remove(at: index)
        case .awards:
            self.awardsTextFields.remove(at: index)
        case .projects:
            self.projectsTextFields.remove(at: index)
        }
        UIView.transition(with: self.tableView ?? UITableView(), duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
        }, completion: nil)
    }
    
    func setupButton(isPopulated: Bool) {
        self.btnSave?.isEnabled = isPopulated
        self.btnSave?.backgroundColor = isPopulated ? UIColor.appColor : UIColor.systemGray
    }
    
    //MARK: Validation for Info textField's text is nil
    func infoValidation() {
        let indicesToCheck = [0, 1, 2, 3, infoTextFields.count - 1]
        isAllPopulated = true
        for index in indicesToCheck {
            let textField = infoTextFields[index]
            if textField.textValue.isEmpty {
                isAllPopulated = false
                break
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for textField's text is nil
    func experienceValidation() {
        for textField in self.experienceTextFields {
            if textField.companyName.isEmpty || textField.startsFrom.isEmpty || textField.endsTo.isEmpty || textField.designation.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for Academics textField's text is nil
    @discardableResult func academicsValidation() -> Bool {
        for textField in self.academicsTextFields {
            if textField.academicDegreeName.isEmpty || textField.academicInstitute.isEmpty || textField.academicStartsFrom.isEmpty || textField.academicEndsTo.isEmpty {
                isAllPopulated = false
                break
            } else {
                isAllPopulated = true
            }
        }
        self.setupButton(isPopulated: isAllPopulated)
        return isAllPopulated
    }
    
    //MARK: Validation for Certificates is nil
    func certificatesValidation() {
        if !certificatesTextField.isEmpty {
            for textField in self.certificatesTextField {
                if textField.certName.isEmpty || textField.certInstitute.isEmpty || textField.certStartsFrom.isEmpty || textField.certEndsTo.isEmpty {
                    isAllPopulated = false
                    break
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Validation for Awards
    func awardsValidation() {
        if !awardsTextFields.isEmpty {
            for textField in self.awardsTextFields {
                if textField.awardTitle.isEmpty {
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
    
    //MARK: Validation for Skills is nil
    @discardableResult func technicalSkillsValidation() -> Bool {
        if !technicalSkillsTextField.isEmpty {
            for textField in self.technicalSkillsTextField {
                if textField.skillName.isEmpty {
                    isAllPopulated = false
                    break
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
        return isAllPopulated
    }
    
    @discardableResult func nonTechnicalSkillsValidation() -> Bool {
        if !nonTechnicalSkillsTextField.isEmpty {
            for textField in self.nonTechnicalSkillsTextField {
                if textField.skillName.isEmpty {
                    isAllPopulated = false
                    break
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
        return isAllPopulated
    }
    
    @discardableResult func toolsValidation() -> Bool {
        if !toolsTextField.isEmpty {
            for textField in self.toolsTextField {
                if textField.skillName.isEmpty {
                    isAllPopulated = false
                    break
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
        return isAllPopulated
    }
    
    //MARK: Validation for Projects textField's text is nil
    func projectsValidation() {
        if !projectsTextFields.isEmpty {
            for textField in self.projectsTextFields {
                if textField.projectName.isEmpty || textField.projectType.isEmpty || textField.projectTechStack.isEmpty || textField.projectImage.isEmpty {
                    isAllPopulated = false
                    break
                } else {
                    isAllPopulated = true
                }
            }
        } else {
            isAllPopulated = true
        }
        self.setupButton(isPopulated: isAllPopulated)
    }
    
    //MARK: Info Tab TextField Validation
    func infoTabTextFieldValidation() -> Bool {
        let email = infoTextFields[2].textValue
        let phone = infoTextFields[3].textValue
        let git = infoTextFields[4].textValue
        let linkedIn = infoTextFields[5].textValue
        var isValid = true
        
        if !email.isEmailValid() {
            AlertHandler.shared.alert(message: Localization.Login.kEmailInvalidError)
            isValid = false
        } else if git != "" && !git.isValidUrl() {
            AlertHandler.shared.alert(message: Localization.ResumeCV.kGitInvalidError)
            isValid = false
        } else if linkedIn != "" && !linkedIn.isValidUrl() {
            AlertHandler.shared.alert(message: Localization.ResumeCV.kLinkedInInvalidError)
            isValid = false
        }
        return isValid
    }
    
    //MARK: Project Tab TextField Validation
    func projectTextFieldValidation() -> Bool {
        var isValid = true
        for textField in projectsTextFields {
            if textField.projectLink != "" {
                let projectLink = textField.projectLink
                if !projectLink.isValidUrl() {
                    AlertHandler.shared.alert(message: Localization.ResumeCV.kProjectInvalidLink)
                    isValid = false
                }
            }
        }
        return isValid
    }
    
    func setTextAfterValidation(tag: Int, color: UIColor = .black) {
        if let phoneCellIndexPath = indexPathForTextField(withTag: tag) {
            let cell = tableView?.cellForRow(at: phoneCellIndexPath) as? BasicInfoTVCell
            cell?.lblTitle.textColor = color
        }
    }
    
    func indexPathForTextField(withTag tag: Int) -> IndexPath? {
        for (index, infoTextField) in infoTextFields.enumerated() {
            if infoTextField.tag == tag {
                return IndexPath(row: index, section: 0)
            }
        }
        return nil
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
    
    //MARK: Reload TableView and scroll to row with Transition
    func reloadAndScrollTableView(count: Int, section: Int) {
        UIView.transition(with: self.tableView!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView?.reloadData()
            self.tableView?.scrollToRow(at: IndexPath(row: count-1, section: section), at: .none, animated: false)
        }, completion: nil)
    }
    
    func updateCVIndex(value: Int) {
        let index = IndexPath(item: value, section: 0)
        self.selectAndUpdateCV(indexPath: index)
        self.updateTableView()
    }
    
    func saveButtonPressed() {
        guard let btnSave = self.btnSave else {return}
        switch category {
        case .info:
            if btnSave.isEnabled && infoTabTextFieldValidation() {
                self.buttonPressed(btnSave)
            }
            
        case .experience:
            if btnSave.isEnabled {
                self.buttonPressed(btnSave)
            }
        case .skills:
            if btnSave.isEnabled {
                self.buttonPressed(btnSave)
            }
        case .academics:
            if btnSave.isEnabled {
                self.buttonPressed(btnSave)
            }
        case .projects:
            if btnSave.isEnabled && projectTextFieldValidation() {
                self.buttonPressed(btnSave)
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
        case .academics:
            let index = IndexPath(item: 1, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        case .skills:
            let index = IndexPath(item: 2, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        case .projects:
            let index = IndexPath(item: 3, section: 0)
            self.selectAndUpdateCV(indexPath: index)
            self.updateTableView()
        }
    }
    
    func goBackPressed(navigation: Bool) {
        PopupView.shared.presentCancelPopup(self.viewController ?? UIViewController(), popupType: .discardInformation) { [self] value in
            if (value != nil) {
                for var index in infoTextFields {
                    index.textValue = ""
                }
                self.experienceTextFields = []
                self.technicalSkillsTextField = []
                self.academicsTextFields = []
                if navigation {
                    self.viewController?.navigationController?.popViewController(animated: true)
                } else {
                    self.viewController?.navigationController?.popToViewController(ofClass: ProfileVC.self)
                }
            }
        }
    }
    
    func showDatePicker(for picker: MonthYearWheelPicker) {
        self.overlayView?.isUserInteractionEnabled = true
        switch picker {
        case startDatePicker:
            self.startDateViewPicker?.isHidden = false
            self.startDatePicker?.isHidden = false
            self.startDatePicker?.reloadAllComponents()
            UIView.transition(with: self.startDateViewPicker ?? UIView(), duration: 0.3, options: .transitionCrossDissolve) {
                self.superView?.layoutIfNeeded()
            }
        case endDatePicker:
            self.endDateViewPicker?.isHidden = false
            self.endDatePicker?.isHidden = false
            self.endDatePicker?.reloadAllComponents()
            UIView.transition(with: self.endDateViewPicker ?? UIView(), duration: 0.3, options: .transitionCrossDissolve) {
                self.superView?.layoutIfNeeded()
            }
        default:
            return
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
        case .academics:
            return 3
        case .skills:
            return 3
        case .projects:
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
                if experienceTextFields.count == 1 {
                    return 1
                } else {
                    return experienceTextFields.count < 5 ? experienceTextFields.count : experienceTextFields.count - 1
                }
            }
        case .skills:
            if section == 0 {
                if technicalSkillsTextField.count == 0 {
                    return 1
                } else {
                    return technicalSkillsTextField.count < 10 ? technicalSkillsTextField.count + 1 : technicalSkillsTextField.count
                }
            } else if section == 1 {
                if nonTechnicalSkillsTextField.count == 0 {
                    return 1
                } else {
                    return nonTechnicalSkillsTextField.count < 10 ? nonTechnicalSkillsTextField.count + 1 : nonTechnicalSkillsTextField.count
                }
            } else {
                if toolsTextField.count == 0 {
                    return 1
                } else {
                    return toolsTextField.count < 10 ? toolsTextField.count + 1 : toolsTextField.count
                }
            }
        case .academics:
            if section == 0 {
                return academicsTextFields.count < 3 ? academicsTextFields.count + 1 : academicsTextFields.count
            } else if section == 1 {
                if certificatesTextField.count == 0 {
                    return 1
                } else {
                    return certificatesTextField.count < 5 ? certificatesTextField.count + 1 : certificatesTextField.count
                }
            } else {
                return awardsTextFields.count < 5 ? awardsTextFields.count + 1 : awardsTextFields.count
            }
        case .projects:
            return projectsTextFields.count + 1
        }
    }
    
    //MARK: View for Header in Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResumeHeaderCell.className) as! ResumeHeaderCell
        
        switch category {
        case .info:
            headerView.lblHeading.text = (section == 0) ? StringConstants.basicInfo : StringConstants.summary
        case .experience:
            headerView.lblHeading.text = (section == 0) ? StringConstants.currentExperience : StringConstants.pastExperience
        case .academics:
            headerView.lblHeading.text = (section == 0) ? StringConstants.addQualifications : (section == 1) ? StringConstants.addCertificates : StringConstants.addAwards
        case .skills:
            headerView.lblHeading.text = (section == 0) ? StringConstants.technicalSkills : (section == 1) ? StringConstants.nonTechnicalSkills : StringConstants.tools
        case .projects:
            headerView.lblHeading.text = StringConstants.addProjects
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
                if indexPath.row == 3 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTVCell.className, for: indexPath) as! PhoneNumberTVCell
                    cell.configure(data: infoTextFields[indexPath.row])
                    cell.phoneDidChange = { [weak self] (phone) in
                        self?.infoTextFields[indexPath.row].textValue = phone
                    }
                    cell.viewController = self.viewController
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: BasicInfoTVCell.className, for: indexPath) as! BasicInfoTVCell
                    cell.configure(infoTextFields[indexPath.row])
                    cell.designation = designations
                    cell.designationID = { [weak self] id in
                        self?.designationID = id
                    }
                    cell.textDidChange = { [weak self] txtField in
                        self?.infoTextFields[indexPath.row].textValue = txtField.text ?? ""
                    }
                    self.validationFields(for: .info)
                    return cell
                }
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTVCell.className, for: indexPath) as! SummaryTVCell
                cell.configure(data: self.infoTextFields[infoTextFields.count-1])
                cell.textDidChange = { [weak self] (txtView) in
                    guard let self = self else {return}
                    self.infoTextFields[self.infoTextFields.count - 1].textValue = txtView.text ?? ""
                }
                self.validationFields(for: .info)
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
                
                cell.tappedStartDate = {
                    self.pickerIndex = indexPath.row
                    self.showDatePicker(for: self.startDatePicker ?? MonthYearWheelPicker())
                }
                
                cell.textDesignationDidChange = { (txtField) in
                    self.experienceTextFields[indexPath.row].designation = txtField.text ?? ""
                }
                
                cell.textComapnyDidChange = { [weak self] (txtField) in
                    self?.experienceTextFields[indexPath.row].companyName = txtField.text ?? ""
                }
                
                cell.textViewDidChange = { [weak self] (txtView) in
                    guard let self = self else {return}
                    self.experienceTextFields[indexPath.row].jobDescription = txtView.text ?? ""
                }
                return cell
                
            } else {
                if experienceTextFields.count == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .previousExperience)
                    cell.addPressed = {
                        self.experienceTextFields.append(ExperienceModel(companyName: "", startsFrom: "", endsTo: "", designation: "", jobDescription: ""))
                        
                        self.reloadAndScrollTableView(count: self.experienceTextFields.count, section: indexPath.section)
                    }
                    return cell
                }
                if indexPath.row == experienceTextFields.count - 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                    if experienceTextFields.count >= 5 {
                        cell.btnAdd.isHidden = true
                    } else {
                        cell.btnAdd.isHidden = false
                    }
                    cell.addMore = {
                        self.experienceTextFields.append(ExperienceModel(companyName: "", startsFrom: "", endsTo: "", designation: "", jobDescription: ""))
                        self.reloadAndScrollTableView(count: self.experienceTextFields.count - 1, section: indexPath.section)
                    }
                    return cell
                } else {
                    cell.txtCompany.isUserInteractionEnabled = true
                    cell.txtEndDate.isUserInteractionEnabled = false
                    cell.configure(experienceTextFields[indexPath.row + 1])
                    cell.deleteStack.isHidden = false
                    cell.endDateStack.isHidden = false
                    cell.lblCount.text = "\(indexPath.row + 1)"
                    
                    cell.tappedStartDate = {
                        self.startDatePicker?.reloadAllComponents()
                        self.pickerIndex = indexPath.row + 1
                        self.showDatePicker(for: self.startDatePicker ?? MonthYearWheelPicker())
                    }
                    
                    cell.tappedEndDate = {
                        self.endDatePicker?.reloadAllComponents()
                        self.pickerIndex = indexPath.row + 1
                        self.showDatePicker(for: self.endDatePicker ?? MonthYearWheelPicker())
                    }
                    
                    cell.textComapnyDidChange = { [weak self] (txtField) in
                        self?.experienceTextFields[indexPath.row+1].companyName = txtField.text ?? ""
                    }
                    
                    cell.textDesignationDidChange = { [weak self] (txtField) in
                        self?.experienceTextFields[indexPath.row + 1].designation = txtField.text ?? ""
                    }
                    
                    cell.textViewDidChange = { [weak self] (txtView) in
                        guard let self = self else {return}
                        self.experienceTextFields[indexPath.row+1].jobDescription = txtView.text ?? ""
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
            }
        case .academics:
            switch indexPath.section {
            case 0:
                if indexPath.row == academicsTextFields.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                    if academicsTextFields.count >= 3 {
                        cell.btnAdd.isHidden = true
                    } else {
                        cell.btnAdd.isHidden = false
                    }
                    cell.addMore = {
                        self.academicsTextFields.append(AcademicsModel(academicDegreeName: "", academicInstitute: "", academicStartsFrom: "", academicEndsTo: ""))
                        self.reloadAndScrollTableView(count: self.academicsTextFields.count, section: indexPath.section)
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AcademicsTVCell.className, for: indexPath) as! AcademicsTVCell
                    if academicsTextFields.count == 1 {
                        cell.btnDeleteCell.isHidden = true
                    } else {
                        cell.btnDeleteCell.isHidden = false
                    }
                    cell.lblCount.text = "\(indexPath.row + 1)"
                    cell.configure(data: academicsTextFields[indexPath.row])
                    
                    cell.startDatePressed = {
                        self.isCertificates = false
                        if let startDatePicker = self.startDatePicker {
                            self.pickerIndex = indexPath.row
                            self.showDatePicker(for: startDatePicker)
                        }
                    }
                    
                    cell.endDatePressed = {
                        self.isCertificates = false
                        if let endDatePicker = self.endDatePicker {
                            self.pickerIndex = indexPath.row
                            self.showDatePicker(for: endDatePicker)
                        }
                    }
                    
                    cell.textDegreeDidChange = { [weak self] (txtField) in
                        self?.academicsTextFields[indexPath.row].academicDegreeName = txtField.text ?? ""
                    }
                    
                    cell.textInstituteDidChange = { [weak self] (txtField) in
                        self?.academicsTextFields[indexPath.row].academicInstitute = txtField.text ?? ""
                    }
                    
                    cell.deleteCell = { [weak self] in
                        guard let self = self else {return}
                        if self.academicsTextFields.count > 0 {
                            self.removeCell(index: indexPath.row, cellType: .academic, section: indexPath.section)
                        }
                    }
                    return cell
                }
                
            case 1:
                if certificatesTextField.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .certificates)
                    cell.addPressed = {
                        self.certificatesTextField.append(CertificatesModel(certName: "", certInstitute: "", certStartsFrom: "", certEndsTo: ""))
                        self.reloadAndScrollTableView(count: self.certificatesTextField.count, section: indexPath.section)
                        self.certificatesValidation()
                    }
                    return cell
                } else {
                    if indexPath.row == certificatesTextField.count {
                        let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                        cell.addMore = {
                            self.certificatesTextField.append(CertificatesModel(certName: "", certInstitute: "", certStartsFrom: "", certEndsTo: ""))
                            self.reloadAndScrollTableView(count: self.certificatesTextField.count, section: indexPath.section)
                        }
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: AddCertificatesTableViewCell.className, for: indexPath) as! AddCertificatesTableViewCell
                        
                        cell.lblCount.text = "\(indexPath.row + 1)"
                        cell.configure(data: certificatesTextField[indexPath.row])
                        cell.txtEndDate.isUserInteractionEnabled = false
                        
                        cell.startDatePressed = {
                            self.isCertificates = true
                            if let startDatePicker = self.startDatePicker {
                                self.pickerIndex = indexPath.row
                                self.showDatePicker(for: startDatePicker)
                            }
                        }
                        
                        cell.endDatePressed = {
                            self.isCertificates = true
                            if let endDatePicker = self.endDatePicker {
                                self.pickerIndex = indexPath.row
                                self.showDatePicker(for: endDatePicker)
                            }
                        }
                        
                        cell.deleteCell = { [weak self] in
                            guard let self = self else {return}
                            if self.certificatesTextField.count > 0 {
                                self.removeCell(index: indexPath.row, cellType: .certificates, section: indexPath.section)
                            }
                        }
                        
                        cell.textCourseDidChange = { [weak self] (txtField) in
                            self?.certificatesTextField[indexPath.row].certName = txtField.text ?? ""
                        }
                        
                        cell.textInstituteDidChange = { [weak self] (txtField) in
                            self?.certificatesTextField[indexPath.row].certInstitute = txtField.text ?? ""
                        }
                        
                        return cell
                    }
                }
            case 2:
                if awardsTextFields.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .awards)
                    cell.addPressed = {
                        self.awardsTextFields.append(AwardsModel(awardTitle: "", awardDescription: ""))
                        self.reloadAndScrollTableView(count: self.awardsTextFields.count, section: indexPath.section)
                        self.awardsValidation()
                    }
                    return cell
                } else {
                    if indexPath.row == awardsTextFields.count {
                        let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                        cell.addMore = {
                            self.awardsTextFields.append(AwardsModel(awardTitle: "", awardDescription: ""))
                            self.reloadAndScrollTableView(count: self.awardsTextFields.count, section: indexPath.section)
                            self.awardsValidation()
                        }
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: AwardsTVCell.className, for: indexPath) as! AwardsTVCell
                        
                        cell.cellCount.text = "\(indexPath.row + 1)"
                        cell.configure(awardsTextFields[indexPath.row])
                        
                        cell.btnDelete = { [weak self] in
                            guard let self = self else {return}
                            if self.awardsTextFields.count > 0 {
                                self.removeCell(index: indexPath.row, cellType: .awards, section: indexPath.section)
                            }
                        }
                        cell.textViewDidChange = { [weak self] (txtView) in
                            self?.awardsTextFields[indexPath.row].awardDescription = txtView.text ?? ""
                        }
                        cell.textFieldDidChange = { [weak self] (txtField) in
                            self?.awardsTextFields[indexPath.row].awardTitle = txtField.text ?? ""
                        }
                        return cell
                    }
                }
            default:
                return UITableViewCell()
            }
        case .skills:
            if indexPath.section == 0 {
                if technicalSkillsTextField.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .technicalSkills)
                    cell.addPressed = {
                        self.technicalSkillsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "TECHNICAL"))
                        self.reloadAndScrollTableView(count: self.technicalSkillsTextField.count, section: indexPath.section)
                        self.technicalSkillsValidation()
                    }
                    return cell
                }
                if indexPath.row == technicalSkillsTextField.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                    cell.addMore = {
                        self.technicalSkillsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "TECHNICAL"))
                        self.reloadAndScrollTableView(count: self.technicalSkillsTextField.count, section: indexPath.section)
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddSkillsTableViewCell.className, for: indexPath) as! AddSkillsTableViewCell
                    cell.lblcount.text = "\(indexPath.row + 1)"
                    cell.txtSkill.placeholder = "Enter skill"
                    cell.lblSkills.text = "Skill"
                    cell.configure(data: technicalSkillsTextField[indexPath.row])
                    
                    cell.textSkillsDidChange = { [weak self] (txtField) in
                        guard let self = self else {return}
                        self.technicalSkillsTextField[indexPath.row].skillName = txtField.text ?? ""
                    }
                    
                    cell.deleteCell = { [weak self] in
                        if self?.technicalSkillsTextField.count ?? 0 >= 1 {
                            self?.removeCell(index: indexPath.row, cellType: .skills, section: indexPath.section)
                        }
                    }
                    return cell
                }
            } else if indexPath.section == 1 {
                if nonTechnicalSkillsTextField.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .nonTechicalSkills)
                    cell.addPressed = {
                        self.nonTechnicalSkillsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "NON_TECHNICAL"))
                        self.reloadAndScrollTableView(count: self.nonTechnicalSkillsTextField.count, section: indexPath.section)
                    }
                    return cell
                }
                if indexPath.row == nonTechnicalSkillsTextField.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                    cell.addMore = {
                        self.nonTechnicalSkillsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "NON_TECHNICAL"))
                        self.reloadAndScrollTableView(count: self.nonTechnicalSkillsTextField.count, section: indexPath.section)
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddSkillsTableViewCell.className, for: indexPath) as! AddSkillsTableViewCell
                    cell.lblcount.text = "\(indexPath.row + 1)"
                    cell.txtSkill.placeholder = "Enter skill"
                    cell.lblSkills.text = "Skill"
                    cell.configure(data: nonTechnicalSkillsTextField[indexPath.row])
                    
                    cell.textSkillsDidChange = { [weak self] (txtField) in
                        guard let self = self else {return}
                        self.nonTechnicalSkillsTextField[indexPath.row].skillName = txtField.text ?? ""
                    }
                    
                    cell.deleteCell = { [weak self] in
                        if self?.nonTechnicalSkillsTextField.count ?? 0 >= 1 {
                            self?.removeCell(index: indexPath.row, cellType: .skills, section: indexPath.section)
                        }
                    }
                    return cell
                }
            } else {
                if toolsTextField.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                    cell.setup(type: .tools)
                    cell.addPressed = {
                        self.toolsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "TOOLS"))
                        self.reloadAndScrollTableView(count: self.toolsTextField.count, section: indexPath.section)
                    }
                    return cell
                }
                if indexPath.row == toolsTextField.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                    cell.addMore = {
                        self.toolsTextField.append(SkillsModel(skillName: "", skillScore: 0, skillType: "TOOLS"))
                        self.reloadAndScrollTableView(count: self.toolsTextField.count, section: indexPath.section)
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddSkillsTableViewCell.className, for: indexPath) as! AddSkillsTableViewCell
                    cell.lblcount.text = "\(indexPath.row + 1)"
                    
                    cell.configure(data: toolsTextField[indexPath.row])
                    cell.txtSkill.placeholder = "Enter tool"
                    cell.lblSkills.text = "Tool"
                    cell.textSkillsDidChange = { [weak self] (txtField) in
                        guard let self = self else {return}
                        self.toolsTextField[indexPath.row].skillName = txtField.text ?? ""
                    }
                    
                    cell.deleteCell = { [weak self] in
                        if self?.toolsTextField.count ?? 0 >= 1 {
                            self?.removeCell(index: indexPath.row, cellType: .skills, section: indexPath.section)
                        }
                    }
                    return cell
                }
            }
        case .projects:
            let cellType: ProjectsCellType
            cellType = projectsTextFields.count == 0 ? .empty : indexPath.row == projectsTextFields.count ? .addMore : .addProjects
            switch cellType {
            case .empty:
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
                cell.setup(type: .projects)
                cell.addPressed = {
                    self.projectsTextFields.append(ProjectsModel(projectName: "", projectType: "", projectTechStack: "", projectLink: "", projectImage: ""))
                    self.reloadAndScrollTableView(count: self.projectsTextFields.count, section: indexPath.section)
                }
                return cell
            case .addMore:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddMoreTVCell.className, for: indexPath) as! AddMoreTVCell
                cell.addMore = {
                    self.projectsTextFields.append(ProjectsModel(projectName: "", projectType: "", projectTechStack: "", projectLink: "", projectImage: ""))
                    self.reloadAndScrollTableView(count: self.projectsTextFields.count, section: indexPath.section)
                }
                return cell
            case .addProjects:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddProjectsTVCell.className, for: indexPath) as! AddProjectsTVCell
                cell.lblCount.text = "\(indexPath.row + 1)"
                
                cell.configure(data: projectsTextFields[indexPath.row])
                
                cell.deleteCell = { [weak self] in
                    guard let self = self else {return}
                    if self.projectsTextFields.count > 0 {
                        self.removeCell(index: indexPath.row, cellType: .projects, section: indexPath.section)
                    }
                }
                cell.projectNameDidChange = { [weak self] (txtField) in
                    self?.projectsTextFields[indexPath.row].projectName = txtField.text ?? ""
                }
                cell.projectTypeDidChange = { [weak self] (txtField) in
                    self?.projectsTextFields[indexPath.row].projectType = txtField.text ?? ""
                }
                cell.technologyStackDidChange = { [weak self] (txtField) in
                    self?.projectsTextFields[indexPath.row].projectTechStack = txtField.text ?? ""
                }
                cell.projectLinkDidChange = { [weak self] (txtField) in
                    self?.projectsTextFields[indexPath.row].projectLink = txtField.text ?? ""
                }
                cell.projectImageDidChange = { [weak self] (imageURL) in
                    self?.projectsTextFields[indexPath.row].projectImage = imageURL
                }
                cell.viewController = self.viewController
                
                return cell
            }
        }
    }
}
