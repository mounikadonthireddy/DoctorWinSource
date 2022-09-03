//
//  DatingResource.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation

struct DatingResource {
    
    func getDatingData(userID: String, completion : @escaping (_ result: ResponseResult<[DatingModel]>) -> Void) {

       let   homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.dating + "?userid=1"
   
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [DatingModel].self) { result in
                
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
