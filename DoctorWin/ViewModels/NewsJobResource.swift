//
//  NewsJobResource.swift
//  DoctorWin
//
//  Created by Mounika on 22/12/21.
//

import Foundation
struct NewsJobResource {
    
    
    func getMyNewsData1(urlString: String, completion : @escaping (_ result: ResponseResult<HomeResponseModel>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: HomeResponseModel.self) { result in
                
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
