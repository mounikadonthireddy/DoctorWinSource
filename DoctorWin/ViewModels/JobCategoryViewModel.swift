//
//  JobCategoryViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation


protocol JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: JobCategoryResponseModel?, error: String?)
}

struct JobCategoryViewModel
{
    var delegate : JobCategoryViewModelDelegate?
    func getTopRecommendedJobs(userID: String) {
        let resource = JobCategoryResource()
        resource.getJobCategoryData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    if data.is_active == true {
                    self.delegate?.didReceiveTopJobs(response: data, error: nil)
                    } else {
                        self.delegate?.didReceiveTopJobs(response: nil, error: "")
                    }
                    
                case .failure(let error):
                    self.delegate?.didReceiveTopJobs(response: nil, error: error)
                }
            
            }
        }
    }
    
    
}
