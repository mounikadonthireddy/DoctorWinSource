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
    let image: String?
    let discussions: Int?
    let bookmark_status: Bool
    let like_status: Bool
    let id: Int
    let follow: Bool
    let chief_complaint: String?
    let like_count: Int
}

struct CaseDetails: Codable {
    let lab_finding: String
    let location: String
    let title: String
    let image: String
    let physical_exam: String
    let chief_complaint: String
    let speciality: String
    let like_count: Int
    let local_exam: String
    let past_illness: String
    let vitus: String
    let drugs: String
    let ProfileName: String
    let family: String
    let diagnosis: String
    let personal: String
    let system_exam: String
    let discussion: Int
    let present_illness: String
    
    
}
