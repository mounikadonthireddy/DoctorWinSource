//
//  ProfileDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 30/10/21.
//

import Foundation

struct ProfileDataModel : Codable {
    let phoneNumber: String?
    let postGraduationInstitute: String?
    let currentInstitute: String?
    let currentDepartment: String?
    let underGraduationInstitute: String?
    let postGraduation: String?
    let profileImage: String?
    let profileName: String?
    let follow: Int?
    let following: Int?
    let appliedJobs: Int?
    let casePost: Int?
    let newsPost: Int?
    let underGraduation: String?
    let email: String?
    let dob: String?
    let gender : String?
    let location : String?
    let language : String?
    let aboutMe: String?
    let skill : String?
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case postGraduationInstitute = "pg_institute_name"
        case currentInstitute = "current_institute"
        case currentDepartment = "current_department"
        case underGraduationInstitute = "ug_institute_name"
        case postGraduation = "pg"
        case profileImage = "profileImage"
        case profileName = "profile_name"
        case follow = "follow"
        case following = "following"
        case appliedJobs = "applied_jobs"
        case casePost = "case_post"
        case newsPost = "news_post"
        case underGraduation = "ug"
        case email
        case dob
        case gender
        case location
        case language
        case aboutMe = "tell_me_about_youself"
        case skill
    }
}
