//
//  PeopleViewModel.swift
//  DoctorWin
//
//  Created by AHP on 05/09/2565 BE.
//

import Foundation
protocol PeopleViewModelDelegate {
    func didReceiveNetworkDataResponse(response: PeopleResponseModel?, error: String?)
}

struct PeopleViewModel {
  
    var delegate: PeopleViewModelDelegate?
    func getPeopleNetworkDataFromAPI(userID: String) {
        let homeResource = NetworkResource()
        homeResource.getPeopleNetworkData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNetworkDataResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNetworkDataResponse(response: nil, error: error)
                }
            }
        }
    }
}
