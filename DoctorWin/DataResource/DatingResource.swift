//
//  DatingResource.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation

struct DatingResource {
    
    func getDatingData(userID: String, completion : @escaping (_ result: ResponseResult<[MatchesModel]>) -> Void) {

        let   homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.dating + ApiEndpoints.userID + "=\(userID)&page=1"
   
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [MatchesModel].self) { result in
                
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
