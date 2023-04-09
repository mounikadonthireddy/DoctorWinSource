//
//  UserDetailsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import Foundation

protocol UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileModel?, error: String?)
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?)
    func didRecivePostsData(response: HomeResponseModel?, error: String?)
}

struct UserDetailsViewModel {
    var delegate : UserDetailsViewModelDelegate?
    func getProfileData(userID: String) {
        let resource = ProfileEditResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getProfileDetails + "?posted_id=\(userID)&display_status=7"
        
        resource.getProfileData(url: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveProfileData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveProfileData(response: nil, error: error)
                }
                
            }
        }
    }
    func getGroupProfileData(userID: String, groupId: String) {
        let resource = ProfileEditResource()
        let homeUrlStr  = ApiEndpoints.baseUrl + ApiEndpoints.getProfileDetails +  "?posted_id=\(groupId)&display_status=8"
        
        resource.getGroupProfileData(url: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveGroupProfileData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveGroupProfileData(response: nil, error: error)
                }
                
            }
        }
    }
    
    func getPostData(display_status: Int, group_id: String, page : Int,posted_id: String ) {
        let homeResource = UserDetailsResource()
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getTabPost + "?display_status=\(display_status)&posted_id=\(posted_id)&page=\(page)&id=\(group_id)"
        print("posted url \(homeUrlStr)")
        homeResource.getUserPostedPostsData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didRecivePostsData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didRecivePostsData(response: nil, error: error)
                }
                
            }
        }
    }
    func getProfileData(userID: String, requestId: String) {
        let resource = ProfileEditResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userDetails + ApiEndpoints.userID + "=\(userID)&requested_user_id=\(requestId)"
        
        resource.getProfileData(url: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveProfileData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveProfileData(response: nil, error: error)
                }
                
            }
        }
    }
}


struct UserDetailsModel: Codable {
    let profile_name: String?
    let current_job_location: String?
    let speciality: String?
    let hightest_qualification: String?
    let profileImage: String?
    let following: Int?
    let follow: Int?
    let followStatus: Bool?
}
struct GroupProfileModel: Codable {
    let name: String?
    let group_id: String?
    let id: Int?
    let image: String?
    let description: String?
    let cover_image: String?
    let total_joined: Int?
    let admin_status: Bool?
    let joined_status: Bool?
    let group_joined_image: [GenderImageModel]?
}
struct GroupProfileDataModel: Codable {
    let is_active: Bool
    let userDetails: GroupProfileModel?
}
