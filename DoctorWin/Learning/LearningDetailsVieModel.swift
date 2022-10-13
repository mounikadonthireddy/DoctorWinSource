//
//  LearningDetailsVieModel.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import Foundation
protocol LearningDetailsVieModelDelegate {
    func didReciveCourseDetails(response: CourseDetailsModel?, error: String?)
    func didReciveCurriculamDetails(response: [CurriculamModel]?, error: String?)
}
struct LearningDetailsVieModel {
    var delegate : LearningDetailsVieModelDelegate?
  
    func getElearningCourseDetails(userID: String, subjectId: String) {
        let homeResource = LearningDetailsResource()
        homeResource.getElearningCourseDetailsData(userID: userID, subjectId: subjectId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCourseDetails(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCourseDetails(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getCurriculamDetails(userID: String, subjectId: String) {
        let homeResource = LearningDetailsResource()
        homeResource.getElearningCurriculamData(userID: userID, subjectId: subjectId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCurriculamDetails(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCurriculamDetails(response: nil, error: error)
                }
            
            }
            
        }
    }
}
