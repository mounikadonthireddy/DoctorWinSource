//
//  PollViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 04/12/21.
//

import Foundation
protocol PollViewModelDelegate {
    func didRecivePollAddStatus(response: BoolResponseModel?, error: String?)
}

struct PollViewModel {
    var delegate : PollViewModelDelegate?
    
    func addPollData(pollModel: AddPollRequestModel) {
        
        let resource = PollResource()
        
        resource.addPollData(request: pollModel){ result in
            DispatchQueue.main.async {
                self.delegate?.didRecivePollAddStatus(response: result, error: nil)
            }
        }
        
    }
}
