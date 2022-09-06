//
//  GroupViewModel.swift
//  DoctorWin
//
//  Created by AHP on 05/09/2565 BE.
//

import Foundation
protocol GroupViewModelDelegate {
    func didReceiveNetworkDataResponse(response: NetworkGroupModel?, error: String?)
}

struct GroupViewModel {
  
    var delegate: GroupViewModelDelegate?
    func getGroupNetworkDataFromAPI(userID: String) {
        let homeResource = NetworkResource()
        homeResource.getNetworkData(userID: userID) { response in
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
