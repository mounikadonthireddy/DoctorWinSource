//
//  HomeResource.swift
//  DoctorWin
//
//  Created by N517325 on 18/11/21.
//

import Foundation
enum ResponseResult<Value> {
    case success(Value)
    case failure(String)
}

struct HomeResource {
    func getHomeData(userID: String, completion : @escaping (_ result: ResponseResult<[HomeDataModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getPollComplaint + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [HomeDataModel].self) { result in
                
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
    func saveComplaintToWishslist(userID: String,complaintID: String, reqModel: ComplaintLikeModel ,completion : @escaping (_ result: ResponseResult<ResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobLike + "?user_id=\(userID)&complaint_id=\(complaintID)"
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(reqModel)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: ResponseModel.self) { (result) in


                switch result {
                   case .success(let data):
                    completion(.success(data))
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                       
                       case .internalServerError:
                        completion(.failure("Please try Again After SomeTime"))

                       
                       case .decodingError:
                        completion(.failure("Please try Again After SomeTime"))

                       case .serverError(error: let error):
                        completion(.failure("Please try Again After SomeTime"))

                       }
                   }
            }
        } catch let error {
            print("error is \(error)")
        }
    }
    func saveComplaintToBookmark(userID: String,complaintID: String, reqModel: ComplaintLikeModel ,completion : @escaping (_ result: String?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintBookmark + "?user_id=\(userID)&complaint_id=\(complaintID)"
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(reqModel)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: ComplaintLikeResponse.self) { (result) in


                switch result {
                   case .success(let data):
                    completion(data.like_status)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(nil)
                       
                       case .internalServerError:
                        completion(nil)

                       
                       case .decodingError:
                        completion(nil)

                       case .serverError(error: let error):
                        completion(nil)

                       }
                   }
            }
        } catch let error {
            print("error is \(error)")
        }
    }
    func followComplaint(request: ComplaintFollowRequest, completion : @escaping  (_ result: String?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintFollow + "?user_id=\(request.user_id)&follow_id=\(request.follow_id)"
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: ComplaintFollowResponse.self) {
                result in
                switch result {
                   case .success(let data):
                    completion(data.follow)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(nil)
                       
                       case .internalServerError:
                        print("Error: Unknown")
                     
                       case .decodingError:
                        print("Error: Unknown")
                       case .serverError(error: let error):
                        print("Error: Unknown")
                       }
            }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    
    func likeComplaint(request: ComplaintLikeRequest, completion : @escaping  (_ result: String?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeJobs + "?user_id=\(request.user_id)&complaint_id=\(request.complaint_id)"
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: ComplaintLikeResponse.self) {
                result in
                switch result {
                   case .success(let data):
                    completion(data.like_status)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(nil)
                       
                       case .internalServerError:
                        print("Error: Unknown")
                     
                       case .decodingError:
                        print("Error: Unknown")
                       case .serverError(error: let error):
                        print("Error: Unknown")
                       }
            }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func saveComplaint(request: ComplaintLikeRequest, completion : @escaping  (_ result: String?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(request.user_id)&complaint_id=\(request.complaint_id)"
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: SaveResponse.self) {
                result in
                switch result {
                   case .success(let data):
                    completion(data.bookmark_status)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(nil)
                       
                       case .internalServerError:
                        print("Error: Unknown")
                     
                       case .decodingError:
                        print("Error: Unknown")
                       case .serverError(error: let error):
                        print("Error: Unknown")
                       }
            }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func replyComplaint(request: PostReplyRequest, completion : @escaping  (_ result: PostReplyResponse) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComplaintComment + "?user_id=\(request.profile)"
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: PostReplyResponse.self) {
                result in
                switch result {
                   case .success(let data):
                    completion(data)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                      
                           print("Error: Unknown")
                       case .internalServerError:
                        print("Error: Unknown")
                     
                       case .decodingError:
                        print("Error: Unknown")
                       case .serverError(error: let error):
                        print("Error: Unknown")
                       }
            }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    
    func getBookmarkCases(urlString: String, completion : @escaping (_ result: ResponseResult<[HomeDataModel]>) -> Void) {
        
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
}
