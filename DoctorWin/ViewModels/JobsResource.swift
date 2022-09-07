//
//  JobsResource.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation
struct JobsResource {
    func getJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getTopJobs + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobUrlStr, resultType: [JobsDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getJobDataBasedOnCategory(userID: String,categoryID: Int, completion : @escaping (_ result: ResponseResult<[CarrierModel]>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs + "?categoryid=\(categoryID)" + "&user_id=\(userID)" + "&page=1"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [CarrierModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getSearchJobData(userID: String,query: String, completion : @escaping (_ result: ResponseResult<[CarrierModel]>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.searchJobs  + "?user_id=\(userID)&" + query
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [CarrierModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getJobAllData(userID: String, completion : @escaping (_ result: ResponseResult<[CarrierModel]>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs +  "?user_id=\(userID)&page=1"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [CarrierModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func saveJob(request: JobApplyRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.createBookMarkJobs + "?user_id=\(request.user_id)&job_id=\(request.job_id)"
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
    func applyJob(request: JobApplyRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.appliedJobs + "?user_id=\(request.user_id)&job_id=\(request.job_id)"
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
    func getJobDetailsData(userID: String,jobId:String, completion : @escaping (_ result: ResponseResult<CarrierJobDetailsModel>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobDetails +  "?user_id=\(userID)&jobid=\(jobId)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: CarrierJobDetailsModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getJobHospitalData(userID: String,jobId: String, completion : @escaping (_ result: ResponseResult<HospitalDetailsModel>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.hospitalDetails +  "?user_id=\(userID)&jobid=\(jobId)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: HospitalDetailsModel.self) { result in
                
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
