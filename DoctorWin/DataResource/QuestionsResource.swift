//
//  QuestionsResource.swift
//  DoctorWin
//
//  Created by N517325 on 07/12/21.
//

import Foundation
struct QuestionsResource {
    func getQuestionData(userID: String, completion : @escaping (_ result: ResponseResult<[QuestionModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.questions + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [QuestionModel].self) { result in
                
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
    func postQuestion(request: QuestionRequest,userId: String, completion  : @escaping (_ result: ResponseModel) -> Void) {
        let urlStr = ApiEndpoints.baseUrl + ApiEndpoints.questions + "?user_id=\(userId)"
        let homeUrl = URL(string: urlStr)!

        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ResponseModel.self) { (result) in

                completion(result)
//                switch result {
//                   case .success(let data):
//                    completion(.success(data))
//
//                   case .failure(let requestError):
//                       switch requestError {
//                       case .invalidUrl:
//                        completion(.failure("Please try Again After SomeTime"))
//
//                       case .internalServerError:
//                        completion(.failure("Please try Again After SomeTime"))
//
//
//                       case .decodingError:
//                        completion(.failure("Please try Again After SomeTime"))
//
//                       case .serverError(error: let error):
//                        completion(.failure("Please try Again After SomeTime"))
//
//                       }
//                   }
            }
        } catch let error {
            print("error is \(error)")
        }
    }
}
