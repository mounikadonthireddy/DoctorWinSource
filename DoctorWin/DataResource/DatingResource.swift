//
//  DatingResource.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation

struct DatingResource {
    
    func getDatingData(userID: String, completion : @escaping (_ result: ResponseResult<MatchesResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.dating
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: MatchesResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    
    func getMyLikedProfileData(likeType: LikeType, completion : @escaping (_ result: ResponseResult<LikedProfileResponseModel?>) -> Void) {
       var homeUrlStr = ApiEndpoints.baseUrl
        if likeType == .myLikes {
            homeUrlStr  += ApiEndpoints.myLikes
        } else if likeType == .others {
            homeUrlStr  += ApiEndpoints.otherLikes
        }
       
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: LikedProfileResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    
    func likeProfile(request: ProfileLikeRequest, completion : @escaping  (_ result: ResponseResult<BoolResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likeProfile 
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: BoolResponseModel.self) {
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
    func skipProfile(request: ProfileSkipRequest, completion : @escaping  (_ result: ResponseResult<SkipProfileResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.skiprofile + ApiEndpoints.userID +  "=\(request.dworks_id)&skip_profile_id=\(request.skip_profile_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: SkipProfileResponseModel.self) {
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
    func undoProfile(request: ProfileUndiRequest, completion : @escaping  (_ result: ResponseResult<UndoProfileResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.undoProfile + ApiEndpoints.userID +  "=\(request.dworks_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: UndoProfileResponseModel.self) {
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
}
