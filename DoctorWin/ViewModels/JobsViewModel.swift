//
//  JobsViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 26/11/21.
//

import Foundation
protocol JobsViewModelDelegate {
    func didReceiveJobsResponse(response: [CarrierModel]?, error: String?)
    func didReceiveCarrierResponse(response: [CarrierModel]?, error: String?)

}

struct JobsViewModel {
    var delegate : JobsViewModelDelegate?
    func getNewsPollArticleComplaintDataFromAPI(userID: String) {
        let homeResource = JobsResource()
        homeResource.getJobData(userID: userID) { response in
//            DispatchQueue.main.async {
////                switch response {
////                case .success(let data):
////                    self.delegate?.didReceiveJobsResponse(response: data, error: nil)
////
////                case .failure(let error):
////                    self.delegate?.didReceiveJobsResponse(response: nil, error: error)
////                }
//            }
        }
    }
    func getJobDataBasedOnCategory(userID: String, categoryID: Int) {
          let jobResource = JobsResource()
          jobResource.getJobDataBasedOnCategory(userID: userID , categoryID: categoryID) { response in
              DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveJobsResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveJobsResponse(response: nil, error: error)
                }
              }

  }
      }
    func getSearchJobData(userID: String, query: String) {
          let jobResource = JobsResource()
          jobResource.getSearchJobData(userID: userID , query: query) { response in
              DispatchQueue.main.async {
//                switch response {
////                case .success(let data):
//////                    self.delegate?.didReceiveJobsResponse(response: data, error: nil)
////
////                case .failure(let error):
//////                    self.delegate?.didReceiveJobsResponse(response: nil, error: error)
//                }
              }

  }
      }
    func getAllJobData(userID: String) {
          let jobResource = JobsResource()
          jobResource.getJobAllData(userID: userID ) { response in
              DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveCarrierResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveCarrierResponse(response: nil, error: error)
                }
              }

  }
      }

}

struct JobApplyViewModel {
    var delegate : JobApplyViewModelDelegate?
    func applyJob(userID: String, jobID: Int) {
          let jobResource = JobApplyResource()
        jobResource.applyJob(userID: userID, jobId: jobID)
       { response in
              DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveJobsResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveJobsResponse(response: nil, error: error)
                }
              }

  }
      }
}
protocol JobApplyViewModelDelegate {
    func didReceiveJobsResponse(response: ResponseModel?, error: String?)
}
