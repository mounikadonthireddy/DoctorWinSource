//
//  NetworkViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import Foundation
protocol NetworkViewModelDelegate {
    func didReceiveNetworkDataResponse(response: [NetworkModel]?, error: String?)
    func didReceiveFollowDataResponse(response: [FollowModel]?, error: String?)
}

struct NetworkViewModel {
    var delegate : NetworkViewModelDelegate?
    func getNetworkDataFromAPI(userID: String) {
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
    
    func getFollowDataFromAPI(userID: String) {
        let homeResource = NetworkResource()
        homeResource.getFollowData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveFollowDataResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveFollowDataResponse(response: nil, error: error)
                }
            }
        }
    }
    
    func getFollowingDataFromAPI(userID: String) {
        let homeResource = NetworkResource()
        homeResource.getFollowingData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveFollowDataResponse(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveFollowDataResponse(response: nil, error: error)
                }
            }
        }
    }
    
    func getRequestDataFromAPI(userID: String) {
        let homeResource = NetworkResource()
        homeResource.getRequestData(userID: userID) { response in
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


struct NetworkModel: Codable {
    let userid: Int?
    let ProfileName: String?
    let ProfileImage: String?
    let hightest_qualification: String?
    let speciality: String?
}
