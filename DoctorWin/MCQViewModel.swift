//
//  MCQViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation
protocol MCQViewModelDelegate {
    func didReciveMCQData(response: [ExamsModel]?, error: String?)

}

struct MCQViewModel {
    var delegate : MCQViewModelDelegate?
 
    func getMCQData(userID: String, index: Int) {
        let homeResource = MCQResource()
        homeResource.getMCQsData(userID: userID, index: index) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveMCQData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveMCQData(response: nil, error: error)
                }
            
            }
            
        }
    }
}
