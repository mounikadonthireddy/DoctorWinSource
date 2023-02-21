//
//  LearningResource.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import Foundation
struct LearningResource {
    func getElearningBannerData(userID: String, completion : @escaping (_ result: ResponseResult<[ElearningBannerModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.learningBanner
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ElearningBannerModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
    }
    
    func getTrendingCourseData(userID: String, completion : @escaping (_ result: ResponseResult<LearningResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.trendingCourses
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: LearningResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
    }
    func getFellowshopCoursesData(userID: String, completion : @escaping (_ result: ResponseResult<FellowshipResponseModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.fellowship
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: FellowshipResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
    }
    func getCoursesCategoriesData(userID: String, completion : @escaping (_ result: ResponseResult<[CoursesCategoryModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.categories
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: CoursesCategoryResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data.learnResponse ?? []))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
    }
    func getCategoryBasedCouresesData(userID: String,subId: String, completion : @escaping (_ result: ResponseResult<LearningCategoryResponseModel?>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getCategoryCourses + "?categoryid=\(subId)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: LearningCategoryResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
    }
    func getFellowshopDataBasedCategory(category: String, completion : @escaping (_ result: ResponseResult<LearningCategoryResponseModel?>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getFellowship + "?name=\(category)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: LearningCategoryResponseModel.self) { result in
                
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
