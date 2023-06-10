//
//  CVPerviewVM.swift
//  RPB
//
//  Created by Bilal Nisar on 01/02/2023.
//

import Foundation

class CVPerviewVM {
    
    //MARK: Variables
    var binder: CVPreviewBinder?
    var viewController: UIViewController?
    var profileID: String?
    
    //MARK: Init
    init(binder: CVPreviewBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    
    init(profileID: String) {
        self.profileID = profileID
    }
    
    //MARK: Main Function
    func mainFunction() {
        binder?.registerCell()
    }
    
    func configure() {
        self.binder?.lblName?.text = self.binder?.profileDetail?.data?.basicInfo?.companyName ?? ""
        self.binder?.lblDesignation?.text = self.binder?.profileDetail?.data?.basicInfo?.designation?.title ?? ""
        self.binder?.profileImage?.setImageURLElsePlaceHolder(url: self.binder?.profileDetail?.data?.profilePicture ?? "", placeholder: UIImage.placeHolder)
    }
    
    func exportPdf() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, DownloadPopupVC.className) as! DownloadPopupVC
        tabbarVC.profileID = self.profileID
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: API CALLS
    func fetchProfileDetail() {
        DispatchQueue.main.async {
            Loader.start()
        }
        UserService.shared.fetchProfileDetail(id: self.profileID ?? "") { response in
            DispatchQueue.main.async {
                Loader.stop()
            }
            switch response {
            case .success(let userResponse):
                self.binder?.profileDetail = userResponse
                self.binder?.experiencesFetched()
                self.configure()
                self.binder?.tableView?.reloadData()
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
    
    //MARK: API Calling for Editting Profile
    func editProfile() {
        UserService.shared.editProfile(id: self.profileID ?? "") { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.binder?.profileDetail = userResponse
                    let screen = UIStoryboard.getVC(from: .main, ResumeCV.className) as! ResumeCV
                    
                    guard let profileDetail = self.binder?.profileDetail,
                          let profileID = self.profileID else { return }
                    
                    let viewModel = ResumeVM(profileDetail: profileDetail, id: profileID)
                    screen.viewModel = viewModel
                    screen.viewModel?.isEdit = true
                    screen.viewModel?.isNavigationFromPreview = true
                    self.viewController?.navigationController?.pushViewController(screen, animated: true)
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Profile Deletion
    func deleteProfile() {
        PopupView.shared.presentCancelPopup(self.viewController!, popupType: .deleteProfile, completionHandler: { value in
            if value != nil {
                guard let profileID = self.profileID else { return }
                UserService.shared.deleteProfile(id: profileID) { response in
                    DispatchQueue.main.async {
                        switch response {
                        case .success(_):
                            self.viewController?.navigationController?.popToViewController(ofClass: ProfileVC.self)
                        case .failure(let error):
                            AlertHandler.shared.alert(message: error.localizedDescription)
                        }
                    }
                }
            }
        })
    }
}
