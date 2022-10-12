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
    let storiesCount: Int?
    let pollsCount: Int?
    let newslikeCount: Int
    let articalsCount : Int
    let casesCount: Int
    let speciality: String?
    let currentLocation: String?
    let qualification: String?
    let followStatus: Bool?
    let dworks_id: String?
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
        case newslikeCount = "news_post_like"
        case pollsCount = "poll_likes"
        case storiesCount = "college_story_likes"
        case articalsCount = "artical_like"
        case casesCount = "case_like"
        case speciality = "speciality"
        case currentLocation = "current_job_location"
        case qualification = "hightest_qualification"
        case followStatus
        case dworks_id
    }
}
struct PersonalInfoEditModel: Codable {
    let phone_number: String
    let email: String
    let gender: String
    let dob: String
    let location: String
    let language: String
    
}
struct ResponseModel: Codable {
    let status: String?
    let message: String?
}
struct BoolResponseModel: Codable {
    let status: Bool?
    let message: String?
}
struct ProfessionalResponseModel: Codable {
    let status: Bool?
    let message: String?
}
struct PersonalInfoEditModel1: Codable {
    let phone_number: String
    let email: String
    let gender: String
    let dob: String
    let location: String
    let language: String
    let profile_name: String
    
}
struct SelfDataEditModel: Codable {
    let highest_qualification: String
    let current_job_location: String
    let speciality: String
    let profile_name: String
    
}
struct SaveResponse: Codable {
    let bookmark_status : String
}
struct JobApplyResponse: Codable {
    let apply_status : Bool
}

struct ComplaintLikeResponse: Codable {
    let like_status: String
}
struct PollLikeResponse: Codable {
    let poll_like_status: String
    let like_count: Int
}
//struct ArticalLikeResponse: Codable {
//    let like_status: String
//    let like_count: Int
//}
struct PostReplyResponse: Codable {
    let message : String?
    let status : String?
    let discussion : Int?

}
struct ProfileUpdateResponseModel: Codable {
    let status: String?
    let message: String?
}

struct StatusResponseModel: Codable {
    let status : Bool
    let like_count: Int?
}
struct ProfessionalEditModel: Codable {
    let current_department: String
    let current_institute: String
    let ug: String
    let ug_institute_name: String
    let pg: String
    let pg_institute_name: String
    
}
