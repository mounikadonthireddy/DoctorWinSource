//
//  UserDetailsResource.swift
//  DoctorWin
//
//  Created by AHP on 06/09/2565 BE.
//

import Foundation

struct UserDetailsResource {
    func getUserPostedPostsData(urlString: String, completion : @escaping (_ result: ResponseResult<[HomeDataModel]>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [HomeDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let requestError):
                    switch requestError {
                    case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                    case .internalServerError:
                        print("Error: Unknown")
                    case .decodingError:
                        print("Error: Unknown")
                    case .serverError(error: let error):
                        print("Error: Unknown")
                    }
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
                    
                case .failure(let requestError):
                    switch requestError {
                    case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                    case .internalServerError:
                        print("Error: Unknown")
                    case .decodingError:
                        print("Error: Unknown")
                    case .serverError(error: let error):
                        print("Error: Unknown")
                    }
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
                    
                case .failure(let requestError):
                    switch requestError {
                    case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                    case .internalServerError:
                        print("Error: Unknown")
                    case .decodingError:
                        print("Error: Unknown")
                    case .serverError(error: let error):
                        print("Error: Unknown")
                    }
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
                    
                case .failure(let requestError):
                    switch requestError {
                    case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                    case .internalServerError:
                        print("Error: Unknown")
                    case .decodingError:
                        print("Error: Unknown")
                    case .serverError(error: let error):
                        print("Error: Unknown")
                    }
                }
                
            }
        }
    }
}


struct PostedQuestionModel: Codable {
    let asked_question: String?
    let number_of_answer: Int?
    let created_date: String?
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

}
