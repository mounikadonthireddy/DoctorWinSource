//
//  MentorResource.swift
//  DoctorWin
//
//  Created by AHP on 21/03/2566 BE.
//

import Foundation
struct MentorResource {
    func getTestimonalsData(pageNum: Int, completion : @escaping (_ result: ResponseResult<TestimonialResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.testimonial
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: TestimonialResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
    func getDailyUpdatesData(pageNum: Int, completion : @escaping (_ result: ResponseResult<DailyUpdatesResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.dailyUpdate
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: DailyUpdatesResponseModel.self) { result in
                
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
