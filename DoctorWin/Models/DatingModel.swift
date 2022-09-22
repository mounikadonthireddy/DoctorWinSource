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
struct MatchesModel: Codable {
    let datingid: String?
    let name: String?
    let intro: String?
    let age: Int?
    let living: String?
    let likes: Bool?
    let block: Bool?
    let skip_status: Bool?
    let genderimage: [GenderImageModel]?
    let interest: [ProfileInterestModel]?
    let profile: [ProfileCharModel]?
    let image1: String?
    let image2:String?
    let image3:String?
    
}
struct ProfileCharModel: Codable {
    let value: String?
    let image: String?
}
