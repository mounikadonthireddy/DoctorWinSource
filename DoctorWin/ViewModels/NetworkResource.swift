//
//  NetworkResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import Foundation
struct NetworkResource {
    func getNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<NetworkGroupModel>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNetworkConnections + ApiEndpoints.userID + "=\(userID)"
        
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
    func getPeopleNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<[PeopleModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getPeoples + "?userid=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [PeopleModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
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
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFollowing + ApiEndpoints.userID + "=\(userID)"
        
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
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getRequest + ApiEndpoints.userID + "=\(userID)&page=1"
        
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
