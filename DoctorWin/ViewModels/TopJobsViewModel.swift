//
//  TopJobsViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation

protocol TopJobsViewModelDelegate {
    func didReceiveTopJobs(response: [JobsDataModel]?, error: String?)
}

struct TopJobsViewModel
{
    var delegate : TopJobsViewModelDelegate?
    func getTopRecommendedJobs(userID: String) {
        let homeResource = JobsResource()
        homeResource.getJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveTopJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveTopJobs(response: nil, error: error)
                }
                
            }
        }
    }
    func getNewsPollArticleComplaintDataFromAPI(userID: String) {
        let homeResource = JobsResource()
        homeResource.getJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveTopJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveTopJobs(response: nil, error: error)
                }
                
            }
        }
    }
    
}
