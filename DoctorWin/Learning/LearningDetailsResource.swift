//
//  LearningDetailsResource.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import Foundation
struct LearningDetailsResource {
    func getElearningCourseDetailsData(userID: String,subjectId: String, completion : @escaping (_ result: ResponseResult<CourseDetailsResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.courseDetails + "?subject=\(subjectId)"
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: CourseDetailsResponseModel.self) { result in
                
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
