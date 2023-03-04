//
//  ConnectResource.swift
//  DoctorWin
//
//  Created by AHP on 13/06/2565 BE.
//

import Foundation
struct ConnectResource {
    func getAllInterests(completion : @escaping (_ result: ResponseResult<InterestResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getInterest
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: InterestResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getEditProfile(userID: String, completion : @escaping (_ result: ResponseResult<ConnectProfileResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.editProfile 
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ConnectProfileResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func UpdateProfile(request: ConnectProfileRequetModel, completion : @escaping (_ result: ResponseResult<BoolResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.editProfile
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: BoolResponseModel.self) { (result) in
                
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
    func getProfileImages(userID: String, completion : @escaping (_ result: ResponseResult<DatingImagesResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getDatingImages
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: DatingImagesResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func submitInterests(request:InterestRequest, completion : @escaping (_ result: ResponseResult<BoolResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getInterest
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: BoolResponseModel.self) { (result) in
                
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
struct InterestRequest : Encodable {
    var userid: String
    var interest : String
}
