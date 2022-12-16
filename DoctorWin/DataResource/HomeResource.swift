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
    func getHomeData(pageNum: Int, completion : @escaping (_ result: ResponseResult<HomeResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.homeApi + "?page=\(pageNum)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: HomeResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
    
    
    func getCaseDetails(userID: String,complaintID: String ,completion : @escaping (_ result: ResponseResult<CaseDetails>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComplaint + ApiEndpoints.userID + "=\(userID)&id=\(complaintID)&page=1"
        let httpUtility = HttpUtility()
        do {
            
            httpUtility.getApiData(urlString: homeUrlStr, resultType: CaseDetails.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
    
    func followComplaint(request: ComplaintFollowRequest, completion : @escaping  (_ result: ResponseResult<Bool?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintFollow + ApiEndpoints.userID + "=\(request.user_id)&follow_id=\(request.follow_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ComplaintFollowResponse.self) {
                result in
                
                switch result {
                case .success(let data):
                    completion(.success(data.follow))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    
   
    
  
    
   
    func replyComplaint(request: PostReplyRequest, completion : @escaping  (_ result: ResponseResult<PostReplyResponse>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComplaintComment + ApiEndpoints.userID + "=\(request.profile)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: PostReplyResponse.self, httpMethod: HTTPMethod.post) {
                result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    
    func getBookmarkCases(urlString: String, completion : @escaping (_ result: ResponseResult<[CasesDataModel]>) -> Void) {
        
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
    
   
    func getComments(userId: String,postID: String, completion : @escaping (_ result: ResponseResult<[CommentModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComments + ApiEndpoints.userID + "=\(userId)" + "&achievement_id=\(postID)"
      
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [CommentModel].self) { result in
                
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

struct LikeSaveFollowResource {
    func addToWishslist(reqModel: LikeRequestModel ,completion : @escaping (_ result: ResponseResult<LikeResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.prefrenceApi
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(reqModel)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: LikeResponseModel.self) { (result) in
                
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
