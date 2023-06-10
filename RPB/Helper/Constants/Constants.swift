//
//  Constants.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import UIKit

class Constants: NSObject {
    private override init() { }
    
    static let email = "admin@synavos.com"
    static let password = "admin@synavos"
    static let authorization = "Authorization"
    static let user = "user"
    static let userInfo = "userInfo"
    static let Error = "Error"
    static let unAuthorized = "Invalid credentials"
    
    //MARK: KEYCLOCK
    
    //MARK: SIGNUP SIGNIN
    static let SomethingWentWrong = "Something went wrong"
    static let refreshError = "Something went wrong, refresh the page"
    
    //    //MARK: ADDRESS
    
    //    //MARK: Product Detail
    
    //    //MARK: Account
    
}

struct StringConstants {
    private init() { }
    
    static let basicInfo = "Basic Info"
    static let summary = "Summary"
    static let currentExperience = "Current Experience"
    static let pastExperience = "Past Experience"
    static let technicalSkills = "Technical Skills"
    static let nonTechnicalSkills = "Non Technical Skills"
    static let tools = "Tools"
    static let addCertificates = "Training & Certifications"
    static let addQualifications = "Qualifications"
    static let addAwards = "Awards & Honors"
    static let addProjects = "Projects"
    static let synavosSolutions = "Synavos Solutions"
    static let workExperience = "Work Experience"
    static let education = "Education"
    static let skills = "Skills"
    static let awards = "Awards / Honors"
    static let certifications = "Trainings & Certifications"
    static let projects = "Projects"
    static let contact = "Contact"
    static let technical = "TECHNICAL"
    static let nonTechnical = "NON_TECHNICAL"
    static let capitalizedTool = "TOOLS"
    static let profilePictureError = ""
}

struct ParameterKeys {
    private init() { }
    
    //Login
    static let email = "email"
    static let password = "password"
    
    //Home
    static let limit = "limit"
    
    //Add Employee
    static let name = "name"
    static let designatipn = "designation"
    static let department = "department"
    static let dateOfBirth = "dateOfBirth"
    static let phone = "phone"
    static let dateOfJoining = "dateOfJoining"
    
    //Add Profile
    static let employeeId = "employeeId"
    static let profileName = "profileName"
    static let profilePicture = "profilePicture"
    
    //Employee
    static let id = "id"
    static let page = "page"
    static let empSearch = "empSearch"
    
    //Resume
    static let basicInfo = "basicInfo"
    static let companyName = "companyName"
    static let designation = "designation"
    static let gitLink = "gitLink"
    static let linkedLink = "linkedLink"
    static let basicInfoSummary = "basicInfoSummary"
    
    //ExportPdf
    static let profileId = "profileId"
    static let individualName = "individualName"
    static let individualPhone = "individualPhone"
    static let individualEmail = "individualEmail"
    static let individualLinkedin = "individualLinkedin"
    static let individualProfileImage = "individualProfileImage"
    static let individualGit = "individualGit"
    static let agencyEmail = "agencyEmail"
    static let agencyPhone = "agencyPhone"
    static let agencyAddress = "agencyAddress"
    static let agencyLogo = "agencyLogo"
    static let agencyWebLink = "agencyWebLink"

    static let experiences = "experiences"
    static let skills = "skills"
    static let certificates = "certificates"
    static let certName = "certName"
    static let certInstitute = "certInstitute"
    static let certStartsFrom = "certStartsFrom"
    static let certEndsTo = "certEndsTo"
    static let academics = "academics"
    static let academicDegreeName = "academicDegreeName"
    static let academicInstitute = "academicInstitute"
    static let academicStartsFrom = "academicStartsFrom"
    static let academicEndsTo = "academicEndsTo"
    static let projects = "projects"
    static let awardsAndHonors = "awardsAndHonors"
}

struct GlobalVariable {
    static var isEnableLogs: Bool = false
}

struct DateFormat {
    static var yy_mm_dd = "yy-MM-dd"
    static let dateFormatyyyMMddTZHHmmss = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static var yyyy_mm_dd = "yyyy-MM-dd"
    static var MMM_yyyy = "MMM yyyy"
    static var eeee_mmm_d_yyyy = "EEEE MMM d, yyyy"
}
