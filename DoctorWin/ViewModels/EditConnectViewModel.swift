//
//  EditConnectViewModel.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import Foundation
protocol EditConnectProfileDelegate {
    func didProfileData(response: ConnectProfileModel?, error: String?)
}
struct EditConnectViewModel {
    var delegate :  EditConnectProfileDelegate?
    
    func loadAllInterest(userId: String) {
        let homeResource = ConnectResource()
        homeResource.getEditProfile(userID: userId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didProfileData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didProfileData(response: nil, error: error)
                }
                
            }
        }
    }
}
struct ConnectProfileModel: Codable {
    let name: String
    let intro: String
    let gender: String
    let age: Int
    let living: String
    let qualification: String
    let profession: String
    let image: [GenderImageModel]
    let interest: EditInterestModel?
    
}

struct EditInterestModel: Codable {
    let interestid: String
    let interest: [ProfileInterestModel]
}
