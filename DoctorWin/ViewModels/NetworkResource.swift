//
//  NetworkResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import Foundation
struct NetworkResource {
    func getNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<NetworkGroupModel>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNetworkConnections 
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: NetworkGroupModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getPeopleNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<PeopleResponseModel>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getPeoples
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: jobUrlStr, resultType: PeopleResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                    completion(.success(data))
                    } else {
                        completion(.failure(""))
                    }
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getFollowData(userID: String, completion : @escaping (_ result: ResponseResult<[FollowModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFollow + ApiEndpoints.userID + "=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [FollowModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getFollowingData(userID: String, completion : @escaping (_ result: ResponseResult<[FollowModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFollowing + ApiEndpoints.userID + "=\(userID)&page=1"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [FollowModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getRequestData(userID: String, completion : @escaping (_ result: ResponseResult<[NetworkModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getRequest + ApiEndpoints.userID + "=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [NetworkModel].self) { result in
                
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
