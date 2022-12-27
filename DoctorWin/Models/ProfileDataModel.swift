//
//  ProfileDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 30/10/21.
//

import Foundation
//struct ProfileModel {
//    let name: String
//    let imageName: String
//}
struct ProfileDetailsResponseModel: Codable {
    let is_active: Bool?
    let userDetails: ProfileDataModel?
}
struct UserProfileModel: Codable {
    let is_active: Bool
    let userDetails: ProfileModel?
}
struct ProfileModel: Codable {
    let name: String?
    let image: String?
    let speciality: String?
    let cover_image: String?
    let following_count: Int
    let hightest_qualification: String?
    let follow_status: Bool
    let follow_count: Int
    let location: String?
}
struct ProfileDataModel : Codable {
    let phone_number: String?
    let email:String?
    let name: String?
    let current_job_location: String?
    let speciality: String?
    let hightest_qualification: String?
    let image: String?
    let cover_image: String?
    let current_department: String?
    let current_institute: String?
    let dob: String?
    let gender: String?
    let language: String?
    let degrees: String?
    let ug: String?
    let pg: String?
    let ug_institute_name: String?
    let pg_institute_name: String?
    let skill: String?
    let tell_me_about_youself: String?
    let user: Int?
    let resume: String?
    let experience: [ExperienceModel]?
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
    let is_active: Bool?
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
    let likes: Bool?
    
}
struct ProfessionalEditModel: Codable {
    let current_department: String
    let current_institute: String
    let ug: String
    let ug_institute_name: String
    let pg: String
    let pg_institute_name: String
    
}


struct BookmarkStatusResponseModel: Codable {
    let status : Bool
    let bookmark_count: Int?
    let bookmark: Bool?
}
struct SkipProfileResponseModel: Codable {
    let skiped_profile : Bool?
    let status: Bool?
}
struct UndoProfileResponseModel: Codable {
    let undo : Bool?
    let status: Bool?
    let rest_profile: Int?
}
