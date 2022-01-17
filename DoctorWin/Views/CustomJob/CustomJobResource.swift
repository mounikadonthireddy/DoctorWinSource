//
//  CustomJobResource.swift
//  DoctorWin
//
//  Created by N517325 on 01/12/21.
//

import Foundation
struct CustomJobResource {
    func getCustomJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        let customJobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.customJobs + "?userid=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: customJobUrlStr, resultType: [JobsDataModel].self) { result in
                
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
    func getSavedJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        let savedJobUrl = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: savedJobUrl, resultType: [JobsDataModel].self) {result in
                
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
                        print(error)
                    }
                }
                
            }
        }
    }
    func getAppliedJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        let appliedJobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.appliedJobs + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: appliedJobUrlStr, resultType: [JobsDataModel].self) { result in
                
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
