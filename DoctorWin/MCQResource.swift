//
//  MCQResource.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation
struct MCQResource {
    
    
    func getMCQsData(userID: String,index: Int,  completion : @escaping (_ result: ResponseResult<[ExamsModel]>) -> Void) {
        var homeUrlStr = ""
        if index == 0 {
            homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.mcq + ApiEndpoints.userID + "=\(userID)"
        } else if index == 1 {
         homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.attemptedMcq + ApiEndpoints.userID + "=\(userID)"
        }
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ExamsModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }

}
