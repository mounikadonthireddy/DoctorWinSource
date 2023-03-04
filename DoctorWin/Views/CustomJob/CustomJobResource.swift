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
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getSavedJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        let savedJobUrl = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: savedJobUrl, resultType: [JobsDataModel].self) {result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getBookmarkedJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobModel]>) -> Void) {
        let savedJobUrl = ApiEndpoints.baseUrl + ApiEndpoints.savedJobs + ApiEndpoints.userID + "=\(userID)&page=1"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: savedJobUrl, resultType: [JobModel].self) {result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    
    func getAppliedJobData(userID: String, completion : @escaping (_ result: ResponseResult<AppliedJobResponse>) -> Void) {
        let appliedJobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.appliedJobs 
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: appliedJobUrlStr, resultType: AppliedJobResponse.self) { result in
                
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
