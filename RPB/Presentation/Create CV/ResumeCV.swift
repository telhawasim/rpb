//
//  ResumeCV.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

struct TextFieldModel {
    var title: String
    var placeholder: String
    var textValue: String = ""
    var tag: Int = 0
    var capitalizationType: UITextAutocapitalizationType = .none
    
    static func getInfoTextFields() -> [TextFieldModel] {
        var textFields = [TextFieldModel]()
        textFields.append(TextFieldModel(title: "Name", placeholder: "Dawid", tag: 0, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Designation", placeholder: "UI/UX Designer", tag: 1, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Email Address", placeholder: "dawid.name@gmail.com", tag: 2))
        textFields.append(TextFieldModel(title: "Phone Number", placeholder: "03350438764", tag: 3))
        textFields.append(TextFieldModel(title: "Git / Bit Bucket", placeholder: "Dawid.name@bitbucket.org", tag: 4,  capitalizationType: .words))
        textFields.append(TextFieldModel(title: "LinkedIn", placeholder: "linkedin.com/dawid.name", tag: 5))
        return textFields
    }
}

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
    var category: Category = .info
    
    var infoTextFields = TextFieldModel.getInfoTextFields() {
        didSet {
            self.validation()
        }
    }
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLabel()
        self.configureTableView()
        self.configureCollectionView()
        infoModel = [(Section(section: "Basic Info", rows: 5, expanded: true)),
                     (Section(section: "Education", rows: 5, expanded: false)),
                     (Section(section: "Summary", rows: 1, expanded: false))]
        skillsModel = [(Section(section: "Soft Skills", rows: 1, expanded: true)),
                       (Section(section: "Hard Skills", rows: 1, expanded: false))]
        experienceModel = [Section(section: "Add Experience", rows: 1, expanded: true)]
        self.configureButtons()
        self.btnSave.isEnabled = false
        self.btnSave.backgroundColor = UIColor.systemGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
        tableView.reloadData()
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
                if skillsModel[selectedHeader].expanded == false {
                    skillsModel[selectedHeader].expanded = true
                } else {
                    skillsModel[selectedHeader].expanded = false
                }
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
        self.tableView.register(UINib(nibName: ResumeHeaderCell.className, bundle: nil), forHeaderFooterViewReuseIdentifier: ResumeHeaderCell.className)
    }
    
    //MARK: Configure CollectionView
    func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CategoryCVCell.className)
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
        } else if category == .experience {
            btnPreview.isHidden = false
        } else if category == .skills {
            btnPreview.isHidden = false
        } else {
            btnPreview.isHidden = false
        }
    }
    
    @IBAction func btnGoBack(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        switch category {
        case .info:
            print("Info")
        case .experience:
            print("Experience")
        case .skills:
            print("Skills")
        case .academics:
            print("Academics")
        }
    }
    
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
}

//MARK: CollectionView Methods
extension ResumeCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as! CategoryCVCell
        cell.lblTitle.text = categoryTitle[indexPath.row].rawValue
        cell.isSelected = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.0, height: 42.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        category = categoryTitle[indexPath.row]
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: { self.tableView.reloadData()
            self.configureButtons()
        }, completion: nil)
    }
}

//MARK: TableView Methods
extension ResumeCV: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch category {
        case .info:
            return 1
        case .experience:
            return 0
        case .skills:
            return 0
        case .academics:
            return 0
        }
    }
    
    //MARK: Number of rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .info:
            return infoTextFields.count
        case .experience:
            return 0
        case .skills:
            return 0
        case .academics:
            return 0
        }
    }
    
    //MARK: View for Header in Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ResumeHeaderCell.className) as! ResumeHeaderCell
        headerView.lblHeading.text = "Basic Info"
        
        //        switch category {
        //            case .info:
        //
        //            case .skills:
        //
        //            case .experience:
        //
        //            case .academics:
        //
        //            default:
        //        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTVCell", for: indexPath) as! BasicInfoTVCell
            cell.configure(infoTextFields[indexPath.row])
            cell.textDidChange = { [weak self] (txtField) in
                self?.infoTextFields[indexPath.row].textValue = txtField.text ?? ""
            }
            return cell
            
        case .experience:
            return UITableViewCell()
            
        case .skills:
            return UITableViewCell()
            
        case .academics:
            return UITableViewCell()
        }
    }
}

//MARK: ExperienceTVCell Delegate
extension ResumeCV: ExperienceTVCellProtocol {
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
