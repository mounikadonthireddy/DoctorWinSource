//
//  EditConnectViewModel.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import Foundation
protocol EditConnectProfileDelegate {
    func didProfileData(response: ConnectProfileResponseModel?, error: String?)
    func didProfileImageData(response: DatingImagesResponseModel?, error: String?)
    func updateProfile(response: BoolResponseModel?, error: String?)
}
struct EditConnectViewModel {
    var delegate :  EditConnectProfileDelegate?
    
    func loadProfileData(userId: String) {
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
    func UpdateProfileData(request: ConnectProfileRequetModel) {
        let homeResource = ConnectResource()
        homeResource.UpdateProfile(request: request) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.updateProfile(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.updateProfile(response: nil, error: error)
                }
                
            }
        }
    }
    func createProfileData(request: ConnectProfileRequetModel) {
        let homeResource = ConnectResource()
        homeResource.UpdateProfile(request: request) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.updateProfile(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.updateProfile(response: nil, error: error)
                }
                
            }
        }
    }
    func loadImagesData(userId: String) {
        let homeResource = ConnectResource()
        homeResource.getProfileImages(userID: userId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didProfileImageData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didProfileImageData(response: nil, error: error)
                }
                
            }
        }
    }
}
struct ConnectProfileResponseModel: Codable {
    let is_active: Bool?
    let datingResponse: ConnectProfileModel?
}
struct ConnectProfileModel: Codable {
    let id: Int?
    let name: String?
    let intro: String?
    let gender: String?
    let age: Int?
    let living: String?
    let living_in: String?
    let qualification: String?
    let profession: String?
    let interest: String?
    let selected_interest: String?
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
struct DatingImagesResponseModel: Codable {
    let is_active: Bool?
    let datingResponse: [GenderImageModel]?
}
