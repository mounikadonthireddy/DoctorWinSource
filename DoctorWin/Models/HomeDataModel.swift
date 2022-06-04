//
//  HomeDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 27/10/21.
//

import Foundation

struct HomeDataModel: Codable {
    
    let id: Int
    let title : String?
    let postedImage: String?
    let chiefComplaint: String?
    let complaintStatus: Bool?
    let userId: Int?
    let profileName: String?
    let profileImage: String?
    let speciality: String?
    let location: String?
    let bookmarkStatus: Bool?
    let bookmarkCount: Int?
    let likeStatus: Bool?
    let likeCount: Int?
    let discussion: Int?
    let articalStatus: Bool?
    let newsStatus: Bool?
    let questionStatus: Bool?
    let option1: String?
    let option2: String?
    let option3: String?
    let option4: String?
    let question: String?
    let subject: String?
    let detail: String?
    let correctAnswer: String?
    let exam: String?
    let discription: String?
    let selectedOption: String?
    let follow: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case postedImage = "image"
        case chiefComplaint = "chief_complaint"
        case complaintStatus = "complaint_status"
        case userId = "userid"
        case profileImage = "ProfileImage"
        case newsStatus = "newsartical"
        case bookmarkStatus = "bookmark_status"
        case likeStatus = "like_status"
        case likeCount = "like_count"
        case discussion = "discussion"
        case bookmarkCount = "bookmark_count"
        case articalStatus = "art_status"
        case questionStatus = "answer_status"
        case profileName = "ProfileName"
        case speciality = "speciality"
        case location = "location"
        case option1
        case option2
        case option3
        case option4
        case question
        case subject
        case detail
        case correctAnswer = "correct_answer"
        case exam
        case discription
        case selectedOption = "selected_option"
        case follow
    }
    
}

struct CommentModel: Codable {
    let comment_id : Int?
    let comment, ProfileImage, ProfileName : String
    
}
