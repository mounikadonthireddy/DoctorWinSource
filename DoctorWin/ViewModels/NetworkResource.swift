//
//  NetworkResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import Foundation
struct NetworkResource {
    func getNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<NetworkGroupModel>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNetworkConnections + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: NetworkGroupModel.self) { result in
                
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
    func getPeopleNetworkData(userID: String, completion : @escaping (_ result: ResponseResult<[PeopleModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getPeoples + "?userid=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [PeopleModel].self) { result in
                
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
    func getFollowData(userID: String, completion : @escaping (_ result: ResponseResult<[FollowModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFollow + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [FollowModel].self) { result in
                
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
    func getFollowingData(userID: String, completion : @escaping (_ result: ResponseResult<[FollowModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFollowing + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [FollowModel].self) { result in
                
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
    func getRequestData(userID: String, completion : @escaping (_ result: ResponseResult<[NetworkModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getRequest + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [NetworkModel].self) { result in
                
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
