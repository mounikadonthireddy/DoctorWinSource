//
//  ConnectResource.swift
//  DoctorWin
//
//  Created by AHP on 13/06/2565 BE.
//

import Foundation
struct ConnectResource {
    func getAllInterests(completion : @escaping (_ result: ResponseResult<[InterestModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getInterest
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [InterestModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getEditProfile(userID: String, completion : @escaping (_ result: ResponseResult<ConnectProfileModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.editProfile + ApiEndpoints.userID +  "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ConnectProfileModel.self) { result in
                
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
