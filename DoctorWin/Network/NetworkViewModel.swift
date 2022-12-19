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
    let dworks_id: String?
}
struct GroupModel: Codable {
    let id : Int?
    let group_id: String?
    let name: String?
    let description: String?
    let image: String?
    let cover_image: String?
    let total_joined: Int?
   
}
struct AdminGroupModel: Codable {

    let name_of_group: String?
    let image: String?
    let group_id: String?
    let admin_status: Bool?
    let group_status: Bool?
}

struct NetworkGroupModel: Codable {
    let is_active: Bool?
    let otherGroups: [GroupModel]?
    let selfGroups: [AdminGroupModel]?
}

struct PeopleModel: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let hightest_qualification: String?
    let speciality: String?
    let cover_image: String?
    let posted_id: String?
}
struct PeopleResponseModel: Codable {
    let is_active: Bool
    let userDetails: [PeopleModel]?
}
