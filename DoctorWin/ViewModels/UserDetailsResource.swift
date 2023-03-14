//
//  UserDetailsResource.swift
//  DoctorWin
//
//  Created by AHP on 06/09/2565 BE.
//

import Foundation

struct UserDetailsResource {
    func getUserPostedPostsData(urlString: String, completion : @escaping (_ result: ResponseResult<HomeResponseModel>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: HomeResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getUserPostedCasesData(urlString: String, completion : @escaping (_ result: ResponseResult<[CasesDataModel]>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [CasesDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getUserPostedQuestionsData(urlString: String, completion : @escaping (_ result: ResponseResult<[PostedQuestionModel]>) -> Void) {
        
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [PostedQuestionModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getUserPostedAnswersData(urlString: String, completion : @escaping (_ result: ResponseResult<[AnswersModel]>) -> Void) {
        
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [AnswersModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
}

struct PostedQuestionModel: Codable {
    let asked_question: String?
    let number_of_answer: Int?
    let created_date: String?
    let id: Int?
}

struct RepliesModel: Codable {
    let is_active: Bool?
    let question: String?
    let AnswersList: [QuestionRepliesModel]?
}
struct QuestionRepliesModel: Codable {
    let id: Int?
    let description: String?
    let text_description: String?
    let display_status: Int?
    let follow_status: Bool?
    let comment_count: Int?
    let bookmark_status: Bool?
    let userDetails: PostedUserDetailsModel?
    let groupDetails: GroupProfileModel?
    let image: [GenderImageModel]?
    let like_count: Int?
    let like_status: Bool?
    let posted_by: Bool?
}

struct AnswersModel: Codable {
    let ProfileName: String?
    let ProfileImage: String?
    let asked_question: String?
    let ans: String?
    let number_of_comment: Int?
    let number_of_like: Int?
    let bookmark_status: Bool?
    let like_status: Bool?
    let speciality: String?
    let id: Int
    let posted_ans_image: String?
    let cover_image: String?
    
}
struct AnswersModel1: Codable {
    let ProfileName: String?
    let ProfileImage: String?
    let asked_question: String?
    let ans: String?
    let number_of_comment: Int?
    let number_of_like: Int?
    let bookmark_status: Bool?
    let like_status: Bool?
    let speciality: String?
    let posted_ans_id: Int
    let posted_ans_image: String?
    let cover_image: String?
    
}
