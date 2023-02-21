//
//  InterestViewModel.swift
//  DoctorWin
//
//  Created by AHP on 13/06/2565 BE.
//

import Foundation

struct InterestModel: Codable {
    let name: String?
  
}
struct InterestResponseModel: Codable {
    let datingResponse: [InterestModel]?
    let is_active: Bool?
}

protocol InterestViewModelDelegate {
    func didInterestData(response: InterestResponseModel?, error: String?)
    func submitInterestResponse(res: BoolResponseModel?, error: String?)
}

struct  InterestViewModel {
    var delegate :  InterestViewModelDelegate?
    
    func loadAllInterest() {
        let homeResource = ConnectResource()
        homeResource.getAllInterests() { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didInterestData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didInterestData(response: nil, error: error)
                }
                
            }
        }
    }
    func submitInterest(request: InterestRequest) {
        let homeResource = ConnectResource()
        homeResource.submitInterests(request: request) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.submitInterestResponse(res: data, error: nil)
                case .failure(_):
                    self.delegate?.submitInterestResponse(res: nil, error: nil)
                }
            }
        }
    }
}
