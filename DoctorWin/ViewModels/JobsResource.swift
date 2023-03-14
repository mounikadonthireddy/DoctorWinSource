//
//  JobsResource.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation
struct JobsResource {
    func getJobData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
        
        let jobUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getTopJobs + ApiEndpoints.userID + "=\(userID)"
        
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
    func getJobDataBasedOnCategory(userID: String,categoryID: Int, completion : @escaping (_ result: ResponseResult<JobResponseModel>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs + ApiEndpoints.userID + "=\(userID)"  + "&categoryid=\(categoryID)" + "&page=1&limit=10"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: JobResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getSearchJobData(userID: String,query: String, completion : @escaping (_ result: ResponseResult<[JobModel]>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.searchJobs  + ApiEndpoints.userID + "=\(userID)&" + query
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [JobModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func getJobAllData(pageNum: Int, completion : @escaping (_ result: ResponseResult<JobResponseModel>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs + "?page=\(pageNum)&limit=10"
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: JobResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
    func saveJob(id: Int, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.createBookMarkJobs + "?id=\(id)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: StatusResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func applyJob(request: JobApplyRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.prefrenceApi +  "?id=\(request.id)&display_status=\(request.display_status)&preference=\(request.preference)"
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
    func getJobDetailsData(jobId:String, completion : @escaping (_ result: ResponseResult<JobDetailsModel?>) -> Void) {
        
        let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobDetails + "?jobid=\(jobId)"
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: JobDetailsResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                        completion(.success(data.jobResponse))
                    } else {
                        completion(.failure(""))
                    }
                   
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
        }
    }
}
