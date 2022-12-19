//
//  JobCategoryResource.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation
struct JobCategoryResource {
    func getJobCategoryData(userID: String, completion : @escaping (_ result: ResponseResult<JobCategoryResponseModel>) -> Void)  {
        
        let jobCategoryUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getJobCategory 
        
        let httpUtility = HttpUtility()
        do {
            
            
            httpUtility.getApiData(urlString: jobCategoryUrlStr, resultType: JobCategoryResponseModel.self) { result in
                
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
