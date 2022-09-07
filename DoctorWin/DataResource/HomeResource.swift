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
    func getHomeData(userID: String, pageNum: Int, completion : @escaping (_ result: ResponseResult<[HomeDataModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getPollComplaint + "?user_id=\(userID)&page=\(pageNum)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [HomeDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
    func saveComplaintToWishslist(userID: String,complaintID: String, reqModel: ComplaintLikeModel ,completion : @escaping (_ result: ResponseResult<ResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobLike + "?user_id=\(userID)&complaint_id=\(complaintID)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(reqModel)
            
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
    func getCaseDetails(userID: String,complaintID: String ,completion : @escaping (_ result: ResponseResult<CaseDetails>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComplaint + "?user_id=\(userID)&complaint_id=\(complaintID)"
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
    func saveComplaintToBookmark(userID: String,complaintID: String, reqModel: ComplaintLikeModel ,completion : @escaping (_ result: ResponseResult<String?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintBookmark + "?user_id=\(userID)&complaint_id=\(complaintID)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(reqModel)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ComplaintLikeResponse.self) { (result) in
    
                switch result {
                case .success(let data):
                    completion(.success(data.like_status))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
                
            }
        } catch let error {
            print("error is \(error)")
        }
    }
    func followComplaint(request: ComplaintFollowRequest, completion : @escaping  (_ result: ResponseResult<Bool?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintFollow + "?user_id=\(request.user_id)&follow_id=\(request.follow_id)"
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
    
    func likeComplaint(request: ComplaintLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeJobs + "?user_id=\(request.user_id)&complaint_id=\(request.complaint_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
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
    
    func likePoll(request: PollLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeJobs + "?user_id=\(request.user_id)&poll_id=\(request.poll_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
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
    func likeArtical(request: ArticalLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeJobs + "?user_id=\(request.user_id)&art_id=\(request.art_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
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
    func likeNews(request: NewsLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeJobs + "?user_id=\(request.user_id)&artical_id=\(request.artical_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
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
    func saveComplaint(request: ComplaintLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(request.user_id)&complaint_id=\(request.complaint_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self, httpMethod: HTTPMethod.post) {
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
    
    func savePoll(request: PollLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(request.user_id)&poll_id=\(request.poll_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self, httpMethod: HTTPMethod.post) {
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
    func saveArtical(request: ArticalLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(request.user_id)&art_id=\(request.art_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self, httpMethod: HTTPMethod.post) {
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
    func saveNews(request: NewsLikeRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(request.user_id)&artical_id=\(request.artical_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self, httpMethod: HTTPMethod.post) {
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
    func replyComplaint(request: PostReplyRequest, completion : @escaping  (_ result: ResponseResult<PostReplyResponse>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getComplaintComment + "?user_id=\(request.profile)"
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
}

