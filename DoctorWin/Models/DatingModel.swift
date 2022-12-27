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
    let name: String?
}
struct MatchesResponseModel: Codable {
    let is_active: Bool?
    let datingResponse: [MatchesModel]?
}
struct MatchesModel: Codable {
    let id: Int?
    let datingid: String?
    let name: String?
    let intro: String?
    let age: Int?
    let living_in: String?
    let like: Bool?
    let block: Bool?
    let skip_status: Bool?
    let image: [GenderImageModel]?
    let interest: [ProfileInterestModel]?
    let profile: [ProfileCharModel]?
    let image1: String?
    let image2:String?
    let image3:String?
    let looking_for:String?
    let user: Int
}
struct ProfileCharModel: Codable {
    let value: String?
    let image: String?
    let name: String?
}
struct LikedProfileResponseModel: Codable {
    let is_active: Bool?
    let datingResponse: [LikeMatchesModel]?
}

struct LikeMatchesModel: Codable {
    let id: Int?
    let name: String?
    let age: Int?
    let image: String?
   
}
enum LikeType {
    case myLikes
    case others
}
