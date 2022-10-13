//
//  LearningViewModel.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import Foundation
protocol LearningViewModelDelegate {
    func didReciveBannerImage(response: [ElearningBannerModel]?, error: String?)
    func didReciveTrendingCourses(response: [CourseModel]?, error: String?)
    func didReciveCourses(response: [CoursesModel]?, error: String?)
    func didReciveCategories(response: [CoursesCategoryModel]?, error: String?)
}


struct LearningViewModel {
    var delegate : LearningViewModelDelegate?
  
    func getElearningBanner(userID: String) {
        let homeResource = LearningResource()
        homeResource.getElearningBannerData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveBannerImage(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveBannerImage(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getTrendingCourses(userID: String) {
        let homeResource = LearningResource()
      
        homeResource.getTrendingCourseData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveTrendingCourses(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveTrendingCourses(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getCourses(userID: String) {
        let homeResource = LearningResource()
      
        homeResource.getCoursesData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCourses(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCourses(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getCoursesCategeries(userID: String) {
        let homeResource = LearningResource()
      
        homeResource.getCoursesCategoriesData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCategories(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCategories(response: nil, error: error)
                }
            
            }
            
        }
    }
}
