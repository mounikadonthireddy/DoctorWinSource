//
//  LearningDetailsVieModel.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import Foundation
protocol LearningDetailsVieModelDelegate {
    func didReciveCourseDetails(response: CourseDetailsModel?, error: String?)

}
struct LearningDetailsVieModel {
    var delegate : LearningDetailsVieModelDelegate?
  
    func getElearningCourseDetails(userID: String, subjectId: String) {
        let homeResource = LearningDetailsResource()
        homeResource.getElearningCourseDetailsData(userID: userID, subjectId: subjectId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    if data.is_active == true {
                        self.delegate?.didReciveCourseDetails(response: data.learnResponse, error: nil)
                    } else {
                        self.delegate?.didReciveCourseDetails(response: nil, error: "")
                    }
                case .failure(let error):
                    self.delegate?.didReciveCourseDetails(response: nil, error: error)
                }
            
            }
            
        }
    }
}
