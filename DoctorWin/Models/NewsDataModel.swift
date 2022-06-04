//
//  NewsDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import Foundation
struct NewsDataModel: Codable {
    let artical_title: String?
    let artical_image: String?
    let artical_discription: String?
    let username: String?
    let profileImage: String?
    let created_date: String?
    let like_status: Bool?
    let bookmark_status: Bool?
    let userid: Int?
    let id: Int
}
struct NewscategoryDataModel: Codable {
    let title: String?
    let image: String?
    let news: String?
    let username: String?
    let profileImage: String?
    let created_date: String?
    let like_status: Bool?
    let bookmark_status: Bool?
    let id: Int
}
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
struct NewsCategoryModel: Codable {
    let title: String?
    let image: String?
    let id: Int
}
struct ArticalsDataModel: Codable {
    let title: String?
    let discription: String?
    let ProfileName: String?
    let image: String?
    let created_date: String?
    let like_status: Bool?
    let bookmark_status: Bool?
    let speciality: String?
    let like_count: Int?
    let current_job_location: String?
    let ProfileImage: String?
    let id: Int
}
struct NewsModel: Codable {
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
}
