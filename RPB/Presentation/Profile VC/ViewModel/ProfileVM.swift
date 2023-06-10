//
//  ProfileVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit

class ProfileVM {
    
    //MARK: Variables
    weak var binder: ProfileBinder?
    weak var viewController: UIViewController?
    
    //MARK: Init
    init(binder: ProfileBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    
    init(employeeId: String) {
        self.employeeId = employeeId
    }
    
    private var model: ProfileModel?
    var employeeId: String?
    
    //MARK: Main Function
    func main() {
        self.binder?.configureButtons()
        self.binder?.configureFonts()
        self.binder?.configureTableView()
        self.binder?.configureBottomSheet()
        self.binder?.bottomSheetHeight?.constant = 0
        self.binder?.didTapPreviewAt = { [weak self] (id) in
            self?.goToPreviewCV(id: id)
        }
        self.binder?.didTapCreateProfile = {
            self.goToResumeCV()
        }
    }
    
    //MARK: Close Bottom Sheet
    func closeButtonSheet() {
        self.binder?.bottomSheetClose()
    }
    
    //MARK: Delete button Pressed
    func deleteButtonPressed() {
        self.closeButtonSheet()
        self.showPopUp()
    }
    
    //MARK: Go Back {
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Go to PreviewCV
    func goToPreviewCV(id: String) {
        let screen = UIStoryboard.getVC(from: .main, CVPreviewVC.className) as! CVPreviewVC
        let previewVM = CVPerviewVM(profileID: id)
        screen.viewModel = previewVM
        self.viewController?.navigationController?.pushViewController(screen, animated: true)
    }
    
    //MARK: Navigate to Employee Detail Screen
    func navigateProfileScreen(id: String) {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ProfileVC.className) as! ProfileVC
        let profileVM = ProfileVM(employeeId: id)
        tabbarVC.viewModel = profileVM
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Show PopUp
    func showPopUp() {
        PopupView.shared.presentCancelPopup(viewController ?? UIViewController(), popupType: .deleteProfile)
    }
    
    //MARK: Reload Data
    func reloadData() {
        self.fetchProfileListing()
    }
    
    //MARK: All API Calls
    func apiCall() {
        self.fetchEmployeeDetail()
    }
    
    //MARK: API Calling for Downloading Profile
    func goToDownloadProfile() {
        self.closeButtonSheet()
        let tabbarVC = UIStoryboard.getVC(from: .main, DownloadPopupVC.className) as! DownloadPopupVC
        tabbarVC.profileID = self.binder?.profilelisting?.data?[self.binder?.selectedIndex ?? 0].id ?? ""
        tabbarVC.isNavigationProfile = true
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: API Calling for Cloning Profile
    func goToCloneProfile() {
        self.closeButtonSheet()
        PopupView.shared.presentProfilePopup(viewController ?? UIViewController()) { value, textFieldValue in
            if value != nil {
                guard let profileID = self.binder?.profilelisting?.data?[self.binder?.selectedIndex ?? 0].id,
                      let profileName = textFieldValue else {
                    return
                }
                let bodyParams = [ParameterKeys.profileId: profileID, ParameterKeys.profileName: profileName]
                Loader.start()
                UserService.shared.cloneProfileDetail(body: bodyParams) { response in
                    Loader.stop()
                    switch response {
                    case .success(_):
                        self.reloadData()
                    case .failure(let error):
                        AlertHandler.shared.alert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //MARK: API Calling for Employee Detail
    func fetchEmployeeDetail() {
        guard let lblName = binder?.lblName,
              let lblEmail = binder?.lblEmail,
              let lblDesignation = binder?.lblDesignation else { return }
        DispatchQueue.main.async {
            Utilities.showSkeletonForViews(targetViews: [lblName, lblEmail, lblDesignation])
        }
        UserService.shared.fetchEmployeeDetail(id: self.employeeId ?? "") { response in
            DispatchQueue.main.async {
                Utilities.hideSkeletonForViews(targetViews: [lblName, lblEmail, lblDesignation])
                switch response {
                case .success(let userResponse):
                    self.binder?.employeeModel = userResponse
                    self.binder?.populateData(response: userResponse)
                    self.binder?.tableView?.reloadData()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
        self.reloadData()
    }
    
    //MARK: API Calling for Profile Listing
    func fetchProfileListing() {
        let bodyParams = [ParameterKeys.employeeId: self.employeeId ?? ""]
        UserService.shared.fetchProfileListing(params: bodyParams) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.binder?.profilelisting = userResponse
                    self.binder?.tableView?.reloadData()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Profile Deletion
    func deleteProfile() {
        self.closeButtonSheet()
        PopupView.shared.presentCancelPopup(self.viewController!, popupType: .deleteProfile) { value in
            if value != nil {
                UserService.shared.deleteProfile(id: self.binder?.profilelisting?.data?[self.binder?.selectedIndex ?? 0].id ?? "") { response in
                    DispatchQueue.main.async {
                        switch response {
                        case .success(_):
                            self.reloadData()
                            self.closeButtonSheet()
                        case .failure(let error):
                            AlertHandler.shared.alert(message: error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: API Calling for Editting Profile
    func editProfile() {
        UserService.shared.editProfile(id: self.binder?.profilelisting?.data?[binder?.selectedIndex ?? 0].id ?? "") { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.binder?.profileDetail = userResponse
                    let screen = UIStoryboard.getVC(from: .main, ResumeCV.className) as! ResumeCV
                    guard let profileDetail = self.binder?.profileDetail,
                          let profileID = self.binder?.profilelisting?.data?[self.binder?.selectedIndex ?? 0].id,
                          let employeeDetail = self.binder?.employeeModel?.data else { return }
                    let viewModel = ResumeVM(profileDetail: profileDetail, id: profileID, employeeDetail: employeeDetail)
                    screen.viewModel = viewModel
                    screen.viewModel?.isEdit = true
                    self.viewController?.navigationController?.pushViewController(screen, animated: true)
                    self.closeButtonSheet()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling Profile Creation
    func goToResumeCV() {
        PopupView.shared.presentProfilePopup(viewController ?? UIViewController()) { value, textFieldValue in
            if value != nil {
                let bodyParams = [ParameterKeys.profileName: textFieldValue ?? "", ParameterKeys.employeeId: self.employeeId ?? ""]
                UserService.shared.addProfile(body: bodyParams) { [self] response in
                    switch response {
                    case .success(let success):
                        self.model = success
                        let screen = UIStoryboard.getVC(from: .main, ResumeCV.className) as! ResumeCV
                        if let name = self.binder?.employeeModel?.data?.name,
                           let email = self.binder?.employeeModel?.data?.email,
                           let phone = self.binder?.employeeModel?.data?.phone,
                           let designation = self.binder?.employeeModel?.data?.designation?.title,
                           let designationID = self.binder?.employeeModel?.data?.designation?._id,
                           let id = model?.data?._id {
                            let viewModel = ResumeVM(name: name, email: email, phone: phone, id: id, designation: designation, designationID: designationID)
                            screen.viewModel = viewModel
                            self.viewController?.navigationController?.pushViewController(screen, animated: true)
                        }
                    case .failure(let failure):
                        AlertHandler.shared.alert(message: failure.localizedDescription)
                    }
                }
            }
        }
    }
}
