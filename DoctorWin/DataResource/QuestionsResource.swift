//
//  QuestionsResource.swift
//  DoctorWin
//
//  Created by N517325 on 07/12/21.
//

import Foundation
struct QuestionsResource {
    func getQuestionData(userID: String, completion : @escaping (_ result: ResponseResult<[QuestionModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.questions + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [QuestionModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getTrendingQuestionData(userID: String, completion : @escaping (_ result: ResponseResult<[AnswersModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.trendingQuestion
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [AnswersModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getUserPostedQuestionData(userID: String,page:Int, completion : @escaping (_ result: ResponseResult<[PostedQuestionModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userPostedQA + ApiEndpoints.userID + "=\(userID)&page=\(page)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [PostedQuestionModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func postQuestion(request: QuestionRequest,userId: String, completion  : @escaping (_ result: ResponseResult<ResponseModel>) -> Void) {
        let urlStr = ApiEndpoints.baseUrl + ApiEndpoints.questions + ApiEndpoints.userID + "=\(userId)"
        let homeUrl = URL(string: urlStr)!
        
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ResponseModel.self) { (result) in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
              
            }
        } catch let error {
            print("error is \(error)")
        }
    }
}
