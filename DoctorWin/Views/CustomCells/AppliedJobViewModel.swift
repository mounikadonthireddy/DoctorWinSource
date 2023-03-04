//
//  AppliedJobViewModel.swift
//  DoctorWin
//
//  Created by AHP on 09/06/2565 BE.
//

import Foundation
protocol AppliedJobViewModelDelegate {
    func didReceiveAppliedJobs(response: AppliedJobResponse?, error: String?)
}

struct AppliedJobViewModel {
    var delegate : AppliedJobViewModelDelegate?
    
    func getAppliedJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getAppliedJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveAppliedJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveAppliedJobs(response: nil, error: error)
                }
            }
        }
        }
}
