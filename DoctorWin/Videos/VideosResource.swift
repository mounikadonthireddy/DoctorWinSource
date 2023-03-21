//
//  VideosResource.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import Foundation

struct VideosResource {
    func getVideosData(pageNum: Int, completion : @escaping (_ result: ResponseResult<VideosResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.clips
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: VideosResponseModel.self) { result in
                
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
