//
//  CasesDataModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
struct CasesDataModel: Codable {
    let ProfileName: String?
    let current_job_location: String?
    let speciality: String?
    let hightest_qualification: String?
    let ProfileImage: String?
    let title: String?
    let image: [GenderImageModel]?
    let discussions: Int?
    let bookmark_status: Bool
    let like_status: Bool
    let id: Int
    let follow: Bool
    let chief_complaint: String?
    let like_count: Int
    let created_date: String
    
    
}
struct CaseReponseModel: Codable {
    let loggedUser: String?
    let is_active: Bool?
    let homeResponse: CaseDetailsModel?
}
struct CaseDetailsModel: Codable {
    let vitus: String?
    let family: String?
    let groupDetails: GroupProfileModel?
    let posted_date: String?
    let description: String?
    let like_count: Int?
    let local_exam: String?
    let diagnosis: String?
    let follow_status: Bool?
    let personal: String?
    let drugs: String?
    let image: [GenderImageModel]?
    let system_exam: String?
    let bookmark_status: Bool?
    let comment_count: Int?
    let status: Bool?
    let chief_complaint: String?
    let lab_finding: String?
    let imaging: String?
    let present_illness: String?
    let physical_exam: String?
    let userDetails: PostedUserDetailsModel?
    let past_illness: String?
    let title: String?
    let like_status:Bool?
    let group_status: Bool?
    
}
