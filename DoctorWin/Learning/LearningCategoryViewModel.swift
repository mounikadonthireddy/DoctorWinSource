//
//  LearningCategoryViewModel.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import Foundation
protocol LearningCategoryViewModelDelegate {
    func didReciveCategoyBasedCourses(response: [LearningCategoryModel]?, error: String?)
}
struct LearningCategoryViewModel {
    var delegate : LearningCategoryViewModelDelegate?
  
    func getCourses(userID: String, subId:String) {
        let homeResource = LearningResource()
        homeResource.getCategoryBasedCouresesData(userID: userID, subId: subId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCategoyBasedCourses(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCategoyBasedCourses(response: nil, error: error)
                }
            
            }
            
        }
    }
}
