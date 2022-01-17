//
//  HomeDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 27/10/21.
//

import Foundation

struct HomeDataModel: Codable {
    let id: Int?
    let title: String?
    let postedImage: String?
    let complaint: String?
    let discussion: Int?
    let caseName: String?
    let complaintStatus: Bool
    let postedData: String
    let presentIllness: String?
    let pastIllness: String?
    let drugIllness: String?
    let personalIllness: String?
    let familyIllness: String?
    let physicalExamination : String?
    let systemExamination : String?
    let localExamination : String?
    let vitusInvestigation : String?
    let labInvestigation : String?
    let imageInvestigation : String?
    let diagnosResult : String?
    let commentsArray: [CommentModel]?
    let complaintId: Int?
    let pollTitle: String?
    let pollUserName: String?
    let pollUserImage: String?
    let pollStatus: Bool?
    let option1: String?
    let option2: String?
    let option3: String?
    let option4: String?
    let option1Value: Int?
    let option2Value: Int?
    let option3Value: Int?
    let option4Value: Int?
    let votes: Int?
    let likes: Int?
    let bookmarkStatus: Bool?
    let likeStatus: Bool?
    let articalTitle: String?
    let articalDiscription: String?
    let articalProfileName : String?
    let articalProfileImage : String?
    let articalComment: Int?
    let artStatus : Bool?
    let articalImage: String?
    let follow: String?
    let myCaseName: String?
    let caseProfileImage: String?
    let qualification: String?
    let profileName: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "com_title"
        case postedImage = "com_image"
        case complaint = "chief_complaint"
        case discussion = "discussion"
        case caseName = "case_profile_name"
        case complaintStatus = "complaint_status"
        case postedData = "created_date"
        case presentIllness =  "present_illness"
        case pastIllness = "past_illness"
        case drugIllness = "drugs"
        case personalIllness = "personal"
        case familyIllness = "family"
        case physicalExamination = "physical_exam"
        case systemExamination = "system_exam"
        case localExamination = "local_exam"
        case vitusInvestigation = "vitus"
        case labInvestigation = "lab_finding"
        case imageInvestigation = "imaging"
        case diagnosResult = "diagnosis"
        case commentsArray = "comment"
        case complaintId = "complaint_id"
        case pollStatus = "poll_status"
        case pollTitle = "poll_title"
        case pollUserName = "poll_user_name"
        case pollUserImage = "poll_user_image"
        case option1 = "option1"
        case option2 = "option2"
        case option3 = "option3"
        case option4 = "option4"
        case option1Value = "A"
        case option2Value = "B"
        case option3Value = "C"
        case option4Value = "D"
        case votes = "votes"
        case likes = "likes"
        case bookmarkStatus = "bookmark_status"
        case likeStatus = "like_status"
        case articalTitle = "artical_title"
        case articalDiscription = "artical_discription"
        case articalProfileName = "artical_profile_name"
        case articalProfileImage = "artical_profile_image"
        case articalComment = "artical_comment"
        case artStatus = "art_status"
        case articalImage = "mediafile"
        case follow = "follow"
        case myCaseName = "Profile+Name"
        case caseProfileImage = "ProfileImage"
        case qualification = "hightest_qualification"
        case profileName = "ProfileName"
    }
    
}

struct CommentModel: Codable {
    let comment_id : Int?
    let comment, ProfileImage, ProfileName : String
    
}
