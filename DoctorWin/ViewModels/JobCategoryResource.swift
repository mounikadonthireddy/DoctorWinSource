//
//  JobCategoryResource.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation
struct JobCategoryResource {
    func getJobCategoryData(userID: String, completion : @escaping (_ result: ResponseResult<[JobCategoryDataModel]>) -> Void)  {
        
        let jobCategoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getJobCategory + "?user_id=\(userID)"
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategoryUrlStr, resultType: [JobCategoryDataModel].self) { result in
                
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
