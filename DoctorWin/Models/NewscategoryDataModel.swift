//
//  NewscategoryDataModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
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
