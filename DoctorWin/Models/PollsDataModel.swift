//
//  PollsDataModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
struct PollsDataModel: Codable {
    let speciality: String?
    let username: String?
    let poll_title: String?
    let created_date: String
    let profileImage: String?
    let option4: String?
    let option3: String?
    let option2: String?
    let option1: String?
    let bookmark_status: Bool?
    let A, B, C, D : Int
    let id: Int
    let poll_user: Int
    let bookmark_count: Int
    let like_count: Int?
    let vote: Int?
    let follow: String
    let like_status: Bool
    let profile_image: String?
    
}
