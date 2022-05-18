//
//  JobDetailsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/05/22.
//

import Foundation
protocol JobDetailsViewModelDelegate {
    func didReciveHospitalData(response: HospitalDetailsModel?, error: String?)
    func didReceiveJobDetails(response: CarrierJobDetailsModel?, error: String?)

}

struct CarrierJobDetailsViewModel {
    var delegate : JobDetailsViewModelDelegate?
    func getCarrierHospitalDetails(userID: String, JobId: String) {
        let homeResource = JobsResource()
        homeResource.getJobHospitalData(userID: userID, jobId: JobId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveHospitalData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveHospitalData(response: nil, error: error)
                }
            }
        }
    }
    func getCarrierJobDetails(userID: String, JobId: String) {
          let jobResource = JobsResource()
        jobResource.getJobDetailsData(userID: userID , jobId: JobId) { response in
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
