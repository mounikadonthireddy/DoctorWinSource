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
    let living_in: String?
    let qualification: String
    let profession: String
    let genderimage: [GenderImageModel]?
    let interest: [ProfileInterestModel]?
    let looking_for: String?
    let institute: String?
    let orientation: String?
    let height: String?
    let pets: String?
    let income: String?
    let zodiacs: String?
}

struct EditInterestModel: Codable {
    let interestid: String
    let interest: [ProfileInterestModel]
}
