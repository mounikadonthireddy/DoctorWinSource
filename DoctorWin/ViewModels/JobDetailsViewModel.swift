//
//  JobDetailsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/05/22.
//

import Foundation
protocol JobDetailsViewModelDelegate {
    func didReceiveJobDetails(response: JobDetailsModel?, error: String?)
}

struct JobDetailsViewModel {
    var delegate : JobDetailsViewModelDelegate?

    func getCarrierJobDetails(JobId: String) {
          let jobResource = JobsResource()
        jobResource.getJobDetailsData(jobId: JobId) { response in
              DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveJobDetails(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveJobDetails(response: nil, error: error)
                }
              }

  }
      }
   
}
