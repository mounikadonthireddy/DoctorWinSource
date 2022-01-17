//
//  CustomJobViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 01/12/21.
//

import Foundation
protocol CustomJobViewModelDelegate {
    func didReceiveCustomJobs(response: [JobsDataModel]?, error: String?)
}

struct CustomJobViewModel {
    var delegate : CustomJobViewModelDelegate?
    func getCustomJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getCustomJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveCustomJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveCustomJobs(response: nil, error: error)
                }
            
            }
        }
    }
    func getAppliedJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getAppliedJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveCustomJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveCustomJobs(response: nil, error: error)
                }
            }
        }
    }
    func getSavedJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getSavedJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveCustomJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveCustomJobs(response: nil, error: error)
                }
            }
        }
    }
}
