//
//  ArticalsDataModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
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
    let discussion: Int
}
