//
//  FellowshipViewModel.swift
//  DoctorWin
//
//  Created by AHP on 16/01/2566 BE.
//

import Foundation
protocol FellowshipViewModelDelegate {

    func didReciveFellowshipCourses(response: LearningCategoryResponseModel?, error: String?)
}



struct FellowshipViewModel {
    var delegate : FellowshipViewModelDelegate?
  
    func getFellowshipData(categoryName: String) {
        let homeResource = LearningResource()
        homeResource.getFellowshopDataBasedCategory(category: categoryName) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveFellowshipCourses(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveFellowshipCourses(response: nil, error: error)
                }
            
            }
            
        }
    }
}
