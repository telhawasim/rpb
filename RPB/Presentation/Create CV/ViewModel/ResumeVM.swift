//
//  ResumeVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit

class ResumeVM {
    
    weak var binder: ResumeBinder?
    var viewController: UIViewController?
    
    //MARK: Init
    init() { }
    
    init(binder: ResumeBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    
    init(name: String, email: String, phone: String, id: String, designation: String, designationID: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.id = id
        self.designation = designation
        self.designationID = designationID
    }
    
    init(profileDetail: ResumeResponse, id: String) {
        self.profileDetail = profileDetail
        self.id = id
    }
    
    init(profileDetail: ResumeResponse, id: String, employeeDetail: EmployeeListing) {
        self.profileDetail = profileDetail
        self.id = id
        self.employeeDetail = employeeDetail
    }
    
    var name: String?
    var designation: String?
    var designationID: String?
    var email: String?
    var phone: String?
    var linkedIn: String?
    var git: String?
    var summary: String?
    var id: String?
    var infoBodyParams: [String: Any]?
    var profileDetail: ResumeResponse?
    var employeeDetail: EmployeeListing?
    var isEdit: Bool = false
    var isNavigationFromPreview: Bool = false
    
    func main() {
        self.binder?.configureLabel()
        self.binder?.configureTableView()
        self.binder?.configureCollectionView()
        self.binder?.configureButtons()
        self.binder?.configurePicker()
        self.binder?.btnSave?.isEnabled = false
        self.binder?.btnSave?.backgroundColor = UIColor.systemGray
        self.binder?.tableView?.estimatedRowHeight = 80.0
        self.binder?.tableView?.rowHeight = UITableView.automaticDimension
        self.populateData()
        if isEdit {
            if self.profileDetail?.data?.basicInfo != nil {
                self.profileDetailPopulate()
            } else {
                self.editProfilePopulate()
            }
        }
        
    }
    
    func setBasicInfo(data: ResumeModel) {
        self.profileDetail?.data?.basicInfo?.companyName = data.data?.basicInfo?.companyName
        self.profileDetail?.data?.basicInfo?.designation?.title = data.data?.basicInfo?.designation
        self.profileDetail?.data?.basicInfo?.email = data.data?.basicInfo?.email
        self.profileDetail?.data?.basicInfo?.gitLink = data.data?.basicInfo?.gitLink
        self.profileDetail?.data?.basicInfo?.linkedLink = data.data?.basicInfo?.linkedLink
        self.profileDetail?.data?.basicInfo?.basicInfoSummary = data.data?.basicInfo?.basicInfoSummary
    }
    
    func getInfoData() {
        guard let infoTextField = binder?.infoTextFields else { return }
        for textField in infoTextField {
            switch textField.tag {
            case 0:
                name = textField.textValue
            case 1:
                designation = textField.textValue
            case 2:
                email = textField.textValue
            case 3:
                phone = textField.textValue
            case 4:
                git = textField.textValue
            case 5:
                linkedIn = textField.textValue
            case 6:
                summary = textField.textValue
            default:
                return
            }
        }
    }
    
    func getExperienceData() {
        guard let binder = binder else { return }
        let experiences = profileDetail?.data?.experiences ?? []
        let textFieldModels = experiences.compactMap { experience -> ExperienceModel? in
            let model = ExperienceModel(companyName: experience.companyName ?? "",
                                        startsFrom: experience.startsFrom?.convertDateToMMM_YYYY() ?? "",
                                        endsTo: experience.endsTo?.convertDateToMMM_YYYY() ?? "",
                                        designation: experience.designation ?? "",
                                        jobDescription: experience.jobDescription ?? "",
                                        experienceType: experience.experienceType ?? "")
            return model
        }
        binder.experienceTextFields = textFieldModels
    }
    
    func getSkillsData() {
        guard let binder = binder else { return }
        let technicalSkills = profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.technical}) ?? []
        let nonTechnicalSkills = profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.nonTechnical}) ?? []
        let tools = profileDetail?.data?.skills?.filter({$0.skillType == StringConstants.tools.uppercased()}) ?? []
        let technicalSkillsModel = technicalSkills.compactMap { technicalSkills -> SkillsModel? in
            let model = SkillsModel(skillName: technicalSkills.skillName ?? "",
                                    skillScore: technicalSkills.skillScore ?? 0,
                                    skillType: technicalSkills.skillType ?? "")
            return model
        }
        let nonTechnicalSkillsModel = nonTechnicalSkills.compactMap { nonTechnicalSkills -> SkillsModel? in
            let model = SkillsModel(skillName: nonTechnicalSkills.skillName ?? "",
                                    skillScore: nonTechnicalSkills.skillScore ?? 0,
                                    skillType: nonTechnicalSkills.skillType ?? "")
            return model
        }
        let toolsModel = tools.compactMap { tools -> SkillsModel? in
            let model = SkillsModel(skillName: tools.skillName ?? "",
                                    skillScore: tools.skillScore ?? 0,
                                    skillType: tools.skillType ?? "")
            return model
        }
        binder.technicalSkillsTextField = technicalSkillsModel
        binder.nonTechnicalSkillsTextField = nonTechnicalSkillsModel
        binder.toolsTextField = toolsModel
    }
    
    func getCertificatesData() {
        guard let binder = binder else { return }
        let certificates = profileDetail?.data?.certificates ?? []
        let textFieldModels = certificates.compactMap { certificates -> CertificatesModel? in
            guard let certName = certificates.certName,
                  let certInstitute = certificates.certInstitute,
                  let certStartsFrom = certificates.certStartsFrom?.convertDateToMMM_YYYY(),
                  let certEndsTo = certificates.certEndsTo?.convertDateToMMM_YYYY() else {
                return nil
            }
            let model = CertificatesModel(certName: certName, certInstitute: certInstitute, certStartsFrom: certStartsFrom, certEndsTo: certEndsTo)
            return model
        }
        binder.certificatesTextField = textFieldModels
    }
    
    func getAcademicsData() {
        guard let binder = binder else { return }
        let academics = profileDetail?.data?.academics ?? []
        let textFieldModels = academics.compactMap { academics -> AcademicsModel? in
            guard let academicDegreeName = academics.academicDegreeName,
                  let academicInstitute = academics.academicInstitute,
                  let academicStartsFrom = academics.academicStartsFrom?.convertDateToMMM_YYYY(),
                  let academicEndsTo = academics.academicEndsTo?.convertDateToMMM_YYYY() else {
                return nil
            }
            let model = AcademicsModel(academicDegreeName: academicDegreeName, academicInstitute: academicInstitute, academicStartsFrom: academicStartsFrom, academicEndsTo: academicEndsTo)
            return model
        }
        binder.academicsTextFields = textFieldModels
    }
    
    func getAwardsData() {
        guard let binder = binder else { return }
        let awards = profileDetail?.data?.awardsAndHonors ?? []
        let textFieldsModel = awards.compactMap { awards -> AwardsModel? in
            let model = AwardsModel(awardTitle: awards.awardTitle ?? "", awardDescription: awards.awardDescription ?? "")
            return model
        }
        binder.awardsTextFields = textFieldsModel
    }
    
    func getProjectsData() {
        guard let binder = binder else { return }
        let projects = profileDetail?.data?.projects ?? []
        let textFieldModels = projects.compactMap { projects -> ProjectsModel? in
            guard let projectName = projects.projectName,
                  let projectType = projects.projectType,
                  let projectTechStack = projects.projectTechStack,
                  let projectLink = projects.projectLink,
                  let projectImage = projects.projectImage else {
                return nil
            }
            let model = ProjectsModel(projectName: projectName, projectType: projectType, projectTechStack: projectTechStack, projectLink: projectLink, projectImage: projectImage)
            return model
        }
        binder.projectsTextFields = textFieldModels
    }
    
    func editProfilePopulate() {
        guard var infoTextFields = binder?.infoTextFields else { return }
        
        infoTextFields = infoTextFields.map { textField in
            var txtField = textField
            if txtField.tag == 0 {
                
                txtField.textValue = employeeDetail?.name ?? ""
            }
            if txtField.tag == 1 {
                txtField.textValue = employeeDetail?.designation?.title ?? ""
            }
            if txtField.tag == 2 {
                txtField.textValue = employeeDetail?.email ?? ""
            }
            if txtField.tag == 3 {
                txtField.textValue = employeeDetail?.phone ?? ""
            }
            if txtField.tag == 4 {
                txtField.textValue = ""
            }
            if txtField.tag == 5 {
                txtField.textValue = ""
            }
            if txtField.tag == 6 {
                txtField.textValue = ""
            }
            return txtField
        }
        self.binder?.infoTextFields = infoTextFields
        self.binder?.validationFields(for: .info)
    }
    
    func profileDetailPopulate() {
        guard var infoTextFields = binder?.infoTextFields else { return }
        
        infoTextFields = infoTextFields.map { textField in
            var txtField = textField
            if txtField.tag == 0 {
                
                txtField.textValue = profileDetail?.data?.basicInfo?.companyName ?? ""
            }
            if txtField.tag == 1 {
                txtField.textValue = profileDetail?.data?.basicInfo?.designation?.title ?? ""
            }
            if txtField.tag == 2 {
                txtField.textValue = profileDetail?.data?.basicInfo?.email ?? ""
            }
            if txtField.tag == 3 {
                txtField.textValue = profileDetail?.data?.basicInfo?.phone ?? ""
            }
            if txtField.tag == 4 {
                txtField.textValue = profileDetail?.data?.basicInfo?.gitLink ?? ""
            }
            if txtField.tag == 5 {
                txtField.textValue = profileDetail?.data?.basicInfo?.linkedLink ?? ""
            }
            if txtField.tag == 6 {
                txtField.textValue = profileDetail?.data?.basicInfo?.basicInfoSummary ?? ""
            }
            return txtField
        }
        self.binder?.infoTextFields = infoTextFields
        self.binder?.validationFields(for: .info)
    }
    
    func populateData() {
        guard var infoTextField = self.binder?.infoTextFields else {return}
        
        infoTextField = infoTextField.map { textField in
            var txtField = textField
            if txtField.tag == 0 {
                txtField.textValue = self.name ?? ""
            }
            if txtField.tag == 1 {
                txtField.textValue = self.designation ?? ""
            }
            if txtField.tag == 2 {
                txtField.textValue = self.email ?? ""
            }
            if txtField.tag == 3 {
                txtField.textValue = self.phone ?? ""
            }
            return txtField
        }
        
        self.binder?.infoTextFields = infoTextField
        self.binder?.tableView?.reloadData()
    }
    
    //MARK: Save Button Pressed
    func saveButtonPressed() {
        self.binder?.saveButtonPressed()
    }
    
    //MARK: Previous Button Pressed
    func previousButtonPressed() {
        self.binder?.previousButtonPressed()
    }
    
    //MARK: Go Back Button Pressed
    func goBackPressed() {
        self.binder?.goBackPressed(navigation: isNavigationFromPreview)
    }
    
    //MARK: Start Date Button Pressed
    func btnStartDatePressed(_ button: UIButton) {
        self.binder?.doneButtonPressed(button)
    }
    
    func convertExperience(_ model: ExperienceModel) -> ExperienceModel {
        
        var data = model
        
        data.startsFrom = data.startsFrom.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        data.endsTo = data.endsTo.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        
        return data
    }
    
    func convertAcademic(_ model: AcademicsModel) -> AcademicsModel {
        
        var data = model
        
        data.academicStartsFrom = data.academicStartsFrom.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        data.academicEndsTo = data.academicEndsTo.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        
        return data
    }
    
    func convertCertificates(_ model: CertificatesModel) -> CertificatesModel {
        
        var data = model
        
        data.certStartsFrom = data.certStartsFrom.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        data.certEndsTo = data.certEndsTo.convertDate(from: DateFormat.MMM_yyyy, to: DateFormat.yyyy_mm_dd)
        
        return data
    }
    
    //MARK: API Calling for Fetching Designations
    func fetchDesignations() {
        UserService.shared.fetchDesignations { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.binder?.designations = userResponse.data?.designations
                    self.binder?.tableView?.reloadData()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func postProfile() {
        
    }
    
    //MARK: API Calling for Info Information
    func putInfoInformation() {
        self.getInfoData()
        
        if profileDetail?.data?.basicInfo?.designation?.title == self.designation {
            self.designationID = profileDetail?.data?.basicInfo?.designation?._id
        } else {
            if let designationID = self.binder?.designationID {
                self.designationID = designationID
            } else {
                if let employeeDetail = self.employeeDetail {
                    self.designationID = employeeDetail.designation?._id
                }
            }
        }
        
        guard let name = self.name,
              let designationID = self.designationID,
              let email = self.email,
              let phone = self.phone,
              let git = self.git,
              let linkedIn = self.linkedIn,
              let summary = self.summary
        else { return }
        
        infoBodyParams = [
            ParameterKeys.companyName: name,
            ParameterKeys.designation: designationID,
            ParameterKeys.email: email,
            ParameterKeys.phone: phone,
            ParameterKeys.gitLink: git,
            ParameterKeys.linkedLink: linkedIn,
            ParameterKeys.basicInfoSummary: summary
        ]
        
        let bodyParams: [String: Any] = [
            ParameterKeys.basicInfo: infoBodyParams as Any
        ]
        Loader.start()
        UserService.shared.updateProfile(id: self.id ?? "", body: bodyParams) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.setBasicInfo(data: userResponse)
                    self.binder?.updateCVIndex(value: 1)
                    if !(self.profileDetail?.data?.experiences?.isEmpty ?? true) {
                        self.getExperienceData()
                        self.binder?.tableView?.reloadData()
                    }
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Experience Information
    func putExperienceInformation() {
        
        let experienceData = binder?.experienceTextFields.map({convertExperience($0)}).compactMap({$0.toDictionary})
        let bodyParams = [ParameterKeys.experiences: experienceData ?? [:],
                          ParameterKeys.basicInfo: infoBodyParams ?? [:]] as? [String: Any]
        Loader.start()
        UserService.shared.updateProfile(id: self.id ?? "", body: bodyParams ?? [:]) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.profileDetail?.data?.experiences = userResponse.data?.experiences
                    self.binder?.updateCVIndex(value: 2)
                    if !(self.profileDetail?.data?.academics?.isEmpty ?? true) {
                        self.getAcademicsData()
                        self.getCertificatesData()
                        self.getAwardsData()
                        self.binder?.tableView?.reloadData()
                    }
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Academic, Certificate and Awards Information
    func putAcademicInformation() {
        let experienceData = binder?.experienceTextFields.map({convertExperience($0)}).compactMap({$0.toDictionary})
        let certificatesData = binder?.certificatesTextField.map({convertCertificates($0)}).compactMap({$0.toDictionary})
        let academicsData = binder?.academicsTextFields.map({convertAcademic($0)}).compactMap({$0.toDictionary})
        let awardsData = binder?.awardsTextFields.map({($0)}).compactMap({$0.toDictionary})
        
        let bodyParams = [ParameterKeys.experiences: experienceData ?? [:], ParameterKeys.basicInfo: infoBodyParams ?? [:], ParameterKeys.academics: academicsData ?? [:], ParameterKeys.certificates: certificatesData ?? [:], ParameterKeys.awardsAndHonors: awardsData ?? [:]] as [String: Any]
        
        Loader.start()
        UserService.shared.updateProfile(id: self.id ?? "", body: bodyParams) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.profileDetail?.data?.academics = userResponse.data?.academics
                    self.binder?.updateCVIndex(value: 3)
                    if !(self.profileDetail?.data?.skills?.isEmpty ?? true) {
                        self.getSkillsData()
                        self.binder?.tableView?.reloadData()
                    }
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Tools, Technical and Non-Technical Informaation
    func putSkillsInformation() {
        
        let experienceData = binder?.experienceTextFields.map({convertExperience($0)}).compactMap({$0.toDictionary})
        let combinedSkills = (binder?.technicalSkillsTextField ?? []) + (binder?.nonTechnicalSkillsTextField ?? []) + (binder?.toolsTextField ?? [])
        let skillsData = combinedSkills.map({($0)}).compactMap({$0.toDictionary})
        let academicsData = binder?.academicsTextFields.map({convertAcademic($0)}).compactMap({$0.toDictionary})
        let certificatesData = binder?.certificatesTextField.map({convertCertificates($0)}).compactMap({$0.toDictionary})
        let awardsData = binder?.awardsTextFields.map({$0}).compactMap({$0.toDictionary})

        let bodyParams = [ParameterKeys.basicInfo: infoBodyParams ?? [:], ParameterKeys.experiences: experienceData ?? [:], ParameterKeys.academics: academicsData ?? [:], ParameterKeys.certificates: certificatesData ?? [:], ParameterKeys.awardsAndHonors: awardsData ?? [:], ParameterKeys.skills: skillsData] as [String: Any]
        Loader.start()
        UserService.shared.updateProfile(id: self.id ?? "", body: bodyParams) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.profileDetail?.data?.skills = userResponse.data?.skills
                    self.binder?.updateCVIndex(value: 4)
                    if !(self.profileDetail?.data?.projects?.isEmpty ?? true) {
                        self.getProjectsData()
                        self.binder?.tableView?.reloadData()
                    }
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Projects Information
    func putProjetcsInformation() {
        let experienceData = binder?.experienceTextFields.map({convertExperience($0)}).compactMap({$0.toDictionary})
        let combinedSkills = (binder?.technicalSkillsTextField ?? []) + (binder?.nonTechnicalSkillsTextField ?? []) + (binder?.toolsTextField ?? [])
        let skillsData = combinedSkills.map({($0)}).compactMap({$0.toDictionary})
        let certificatesData = binder?.certificatesTextField.map({convertCertificates($0)}).compactMap({$0.toDictionary})
        let academicsData = binder?.academicsTextFields.map({convertAcademic($0)}).compactMap({$0.toDictionary})
        let awardsData = binder?.awardsTextFields.map({$0}).compactMap({$0.toDictionary})
        let projectsData = binder?.projectsTextFields.map({($0)}).compactMap({$0.toDictionary})
        
        let bodyParams = [ParameterKeys.skills: skillsData, ParameterKeys.experiences: experienceData ?? [:], ParameterKeys.awardsAndHonors: awardsData ?? [:], ParameterKeys.basicInfo: infoBodyParams ?? [:], ParameterKeys.certificates: certificatesData ?? [:], ParameterKeys.academics: academicsData ?? [:], ParameterKeys.projects: projectsData ?? [:]] as [String: Any]
        
        Loader.start()
        UserService.shared.updateProfile(id: self.id ?? "", body: bodyParams) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    self.profileDetail?.data?.projects = userResponse.data?.projects
                    let previewVC = UIStoryboard.getVC(from: .main, CVPreviewVC.className) as! CVPreviewVC
                    let profileViewModel = CVPerviewVM(profileID: self.id ?? "")
                    previewVC.viewModel = profileViewModel
                    self.viewController?.navigationController?.pushViewController(previewVC, animated: true)
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
}
