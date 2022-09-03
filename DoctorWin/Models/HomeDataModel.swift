//
//  HomeDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 27/10/21.
//

import Foundation

struct HomeDataModel: Codable {
    let postId:  Int
    let postTitle: String?
    let postImage: String?
    let profileName: String?
    let profileImage: String?
    let speciality: String?
    let coverImage: String
    let likeCount : Int?
    let likeStatus: Bool?
    let bookmarkStatus: Bool?
    let discussionCount: Int?
    let follow: Bool
    let postUserId: Int?
    let postedDate: String
    let isSS_NEET:Bool
    let isPG_NEET: Bool
    let isCase: Bool
    let isSocial: Bool
    let isQuestion: Bool
    enum CodingKeys: String, CodingKey {
        case postId = "id"
        case postTitle = "social_title"
        case postImage = "social_image"
        case profileName = "ProfileName"
        case profileImage = "ProfileImage"
        case speciality
        case coverImage = "cover_image"
        case likeCount  = "like_count"
        case likeStatus = "like_status"
        case bookmarkStatus = "bookmark_status"
        case discussionCount = "discussion"
        case follow
        case postUserId = "user"
        case postedDate = "created_date"
        case isSS_NEET = "SS_NEET"
        case isPG_NEET = "PG_NEET"
        case isCase = "complaint_status"
        case isSocial = "social"
        case isQuestion = "quora"
    }
}
