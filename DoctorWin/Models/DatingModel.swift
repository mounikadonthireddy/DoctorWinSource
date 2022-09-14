//
//  DatingModel.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation
struct DatingModel: Codable {
    let id: Int
    let name: String
    let intro: String
    let gender: String
    let age: Int
    let living: String
    let qualification: String
    let profession: String
    let status: Bool
    let user: Int
    let likes: Bool
    let block: Bool
    let genderimage: [GenderImageModel]
    let interest: [ProfileInterestModel]
}

struct GenderImageModel: Codable {
    let image: String?
}

struct ProfileInterestModel: Codable {
    let interest: String
}
