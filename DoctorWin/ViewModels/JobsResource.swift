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
    func getJobDataBasedOnCategory(userID: String,categoryID: Int, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
            
            let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs + "?categoryid=\(categoryID)" + "&user_id=\(userID)"
            
            let httpUtility = HttpUtility()
            do {
                
                
                httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [JobsDataModel].self) { result in
                    
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
    func getSearchJobData(userID: String,query: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
            
            let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.searchJobs  + "?user_id=\(userID)&" + query
            
            let httpUtility = HttpUtility()
            do {
                
                
                httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [JobsDataModel].self) { result in
                    
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
        func getJobAllData(userID: String, completion : @escaping (_ result: ResponseResult<[JobsDataModel]>) -> Void) {
                
                let jobCategeoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNewJobs +  "?user_id=\(userID)"
                
                let httpUtility = HttpUtility()
                do {
                    
                    
                    httpUtility.getApiData(urlString: jobCategeoryUrlStr, resultType: [JobsDataModel].self) { result in
                        
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
    func saveJob(request: JobApplyRequest, completion : @escaping  (_ result: StatusResponseModel) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.createBookMarkJobs + "?user_id=\(request.user_id)&job_id=\(request.job_id)"
        let homeUrl = URL(string: homeUrlStr)!

        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
                result in

                completion(result)
                    
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func applyJob(request: JobApplyRequest, completion : @escaping  (_ result: StatusResponseModel) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.appliedJobs + "?user_id=\(request.user_id)&job_id=\(request.job_id)"
        let homeUrl = URL(string: homeUrlStr)!

        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
                result in

                    completion(result)
    
            }
            
        } catch let error {
            debugPrint(error)
        }
    }

}
