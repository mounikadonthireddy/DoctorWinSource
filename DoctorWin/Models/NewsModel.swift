//
//  NewsModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
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
    let discription: String?
    let like_count: Int?
}
