//
//  AddProjectsTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 17/04/2023.
//

import UIKit

class AddProjectsTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblCountView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblProjectType: UILabel!
    @IBOutlet weak var lblTechnologyStack: UILabel!
    @IBOutlet weak var lblProjectLink: UILabel!
    @IBOutlet weak var lblUploadImage: UILabel!
    @IBOutlet weak var lblFormat: UILabel!
    @IBOutlet weak var txtProjectName: UITextField!
    @IBOutlet weak var txtProjectType: UITextField!
    @IBOutlet weak var txtTechnologyStack: UITextField!
    @IBOutlet weak var txtProjectLink: UITextField!
    @IBOutlet weak var imgProject: UIImageView!
    @IBOutlet weak var btnRemoveImage: UIButton!
    
    //MARK: Variables
    var deleteCell: (() -> Void)?
    var projectNameDidChange: ((UITextField) -> Void)?
    var projectTypeDidChange: ((UITextField) -> Void)?
    var technologyStackDidChange: ((UITextField) -> Void)?
    var projectLinkDidChange: ((UITextField) -> Void)?
    var projectImageDidChange: ((String) -> Void)?
    var viewController: UIViewController?
    var imgURL: String?

    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgProject.image = UIImage(named: "ic_project_placeholder")
        self.configureFonts()
        self.configureViews()
        self.configureTextfields()
    }
    
    //MARK: Configure Fonts
    func configureFonts() {
        self.lblProjectName.font = UIFont.getSemiBoldFont()
        self.lblProjectType.font = UIFont.getSemiBoldFont()
        self.lblTechnologyStack.font = UIFont.getSemiBoldFont()
        self.lblProjectLink.font = UIFont.getSemiBoldFont()
        self.lblCount.font = UIFont.getSemiBoldFont()
        self.lblUploadImage.font = UIFont.getBoldFont(size: 16)
        self.lblFormat.font = UIFont.getMediumFont()
        
        self.txtProjectName.font = UIFont.getMediumFont()
        self.txtProjectType.font = UIFont.getMediumFont()
        self.txtTechnologyStack.font = UIFont.getMediumFont()
        self.txtProjectLink.font = UIFont.getMediumFont()
    }
    
    func configureTextfields() {
        self.txtProjectName.delegate = self
        self.txtProjectType.delegate = self
        self.txtProjectName.addTarget(self, action: #selector(self.textFieldProjectNameDidChange(_:)), for: .editingChanged)
        self.txtProjectType.addTarget(self, action: #selector(self.textFieldProjectTypeDidChange(_:)), for: .editingChanged)
        self.txtTechnologyStack.addTarget(self, action: #selector(self.textFieldTechnologyStackDidChange(_:)), for: .editingChanged)
        self.txtProjectLink.addTarget(self, action: #selector(self.textFieldProjectLinkDidChange(_:)), for: .editingChanged)
        self.txtProjectLink.autocorrectionType = .no
        self.txtProjectLink.autocapitalizationType = .none
    }
    
    //MARK: Configure Views
    func configureViews() {
        self.lblCountView.cornerRadius(16)
        self.imgProject.cornerRadius(8)
    }
    
    func configure(data: ProjectsModel) {
        self.txtProjectName.text = data.projectName
        self.txtProjectType.text = data.projectType
        self.txtTechnologyStack.text = data.projectTechStack
        self.txtProjectLink.text = data.projectLink
        self.imgProject.setImageURLElsePlaceHolder(url: data.projectImage, placeholder: UIImage.projectPlaceholder)
        
        if data.projectImage.isEmpty {
            self.btnRemoveImage.isHidden = true
        } else {
            self.btnRemoveImage.isHidden = false
        }
    }
    
    //MARK: API Calling for Adding Profile Image
    func uploadImage(image: UIImage, onComplete: @escaping (String?) -> Void) {
        UserService.shared.uploadProfileImage(with: image, parameters: "profilePicture") { response in
            switch response {
            case .success(let url):
                onComplete(url.data?.url)
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
    
    //MARK: Delete Cell Button Pressed
    @IBAction func deleteCellPressed(_ sender: Any) {
        self.deleteCell?()
    }
    
    @IBAction func addImgaePressed(_ sender: Any) {
        CameraHandler.shared.showGalleryActionSheet(viewC: viewController ?? UIViewController())
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imgProject.image = image
            self.btnRemoveImage.isHidden = false
            self.uploadImage(image: image) { imgURL in
                self.imgURL = imgURL ?? ""
                if let url = imgURL {
                    self.imgProject?.setImage(url: url)
                    self.projectImageDidChange?(url)
                } else {
                    self.imgProject?.image = UIImage.projectPlaceholder
                }
            }
        }
    }
    
    @IBAction func removeImagePressed(_ sender: Any) {
        self.imgProject.image = UIImage.projectPlaceholder
        self.projectImageDidChange?("")
        self.btnRemoveImage.isHidden = true
    }
}

//MARK: TextField Delegate Methods
extension AddProjectsTVCell: UITextFieldDelegate {
    @objc private func textFieldProjectNameDidChange(_ textField: UITextField) {
        self.projectNameDidChange?(textField)
    }
    
    @objc private func textFieldProjectTypeDidChange(_ textField: UITextField) {
        self.projectTypeDidChange?(textField)
    }
    
    @objc private func textFieldTechnologyStackDidChange(_ textField: UITextField) {
        self.technologyStackDidChange?(textField)
    }
    
    @objc private func textFieldProjectLinkDidChange(_ textField: UITextField) {
        self.projectLinkDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtProjectName:
            let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        case txtProjectType:
            let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        default:
            break
        }
        return true
    }
}
