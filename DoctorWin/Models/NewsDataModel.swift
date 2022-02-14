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
}
struct PollsDataModel: Codable {
    let artical_title: String?
    let artical_image: String?
    let artical_discription: String?
    let profile_name: String?
    let profileImage: String?
    let created_date: String?
    let like_status: Bool?
    let bookmark_status: Bool?
}
struct NewsCategoryModel: Codable {
    let title: String?
    let image: String?
}
