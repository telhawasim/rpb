//
//  PhoneNumberTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 25/05/2023.
//

import UIKit
import FlagPhoneNumber
import PhoneNumberKit

class PhoneNumberTVCell: UITableViewCell {
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var txtPhone: FPNTextField!
    
    var viewController: UIViewController?
    var isPhoneValid: Bool?
    var phoneNumber: String?
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var phoneDidChange: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
        self.configureTextField()
    }
    
    func configure(data: TextFieldModel) {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(data.textValue)
            let nationalNumber = phoneNumber.nationalNumber
            
            self.txtPhone.text = String(nationalNumber)
        } catch {
            print("Error parsing phone number: \(error)")
        }
        txtPhone.set(phoneNumber: data.textValue)
    }
    
    //MARK: Configure Fonts
    func configureFonts() {
        self.lblPhoneNumber.font = UIFont.getSemiBoldFont()
        self.txtPhone.font = UIFont.getMediumFont()
    }
    
    //MARK: Configure Text Field
    func configureTextField() {
        self.txtPhone.delegate = self
        self.txtPhone.setFlag(key: .PK)
        self.txtPhone.displayMode = .list
        self.txtPhone.tintColor = UIColor.appColor
        listController.setup(repository: txtPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.txtPhone.setFlag(countryCode: country.code)
        }
    }
}

extension PhoneNumberTVCell: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
//        self.selectedCountryCode = code
    }
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(dismissCountries))
        
        listController.navigationItem.leftBarButtonItem = leftButton
        listController.title = "Countries"
        
        self.viewController?.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            self.isPhoneValid = isValid
            self.phoneNumber = textField.getFormattedPhoneNumber(format: .E164) ?? ""
            self.phoneDidChange?(phoneNumber ?? "")
        } else {
            self.phoneNumber = ""
            self.phoneDidChange?(phoneNumber ?? "")
        }
    }
    
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
}
