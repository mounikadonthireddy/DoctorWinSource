//
//  JobApplyResource.swift
//  DoctorWin
//
//  Created by N517325 on 05/12/21.
//

import Foundation
struct JobApplyResource {
    func applyJob(userID: String,jobId: Int ,completion : @escaping (_ result: ResponseResult<ResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.applyJob + "?job_id=\(jobId)&user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ResponseModel.self) { result in
                
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
