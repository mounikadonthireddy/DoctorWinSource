//
//  UserDetailsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import Foundation

protocol UserDetailsViewModelDelegate {
//    func didReceiveFollowDataResponse(response: [FollowModel]?, error: String?)
    func didReceivePostedNews(response: [NewsModel]?, error: String?)
    func didReceivePostedCases(response: [CasesDataModel]?, error: String?)
   
    func didReciveProfileData(response: ProfileDataModel?, error: String?)

}

struct UserDetailsViewModel {
    var delegate : UserDetailsViewModelDelegate?
    
  
    
    
//    func getFollowDataFromAPI(userID: String) {
//        let homeResource = NetworkResource()
//        homeResource.getFollowData(userID: userID) { response in
//            DispatchQueue.main.async {
//                switch response {
//                case .success(let data):
//                    self.delegate?.didReceiveFollowDataResponse(response: data, error: nil)
//
//                case .failure(let error):
//                    self.delegate?.didReceiveFollowDataResponse(response: nil, error: error)
//                }
//            }
//        }
//    }
//
//    func getFollowingDataFromAPI(userID: String) {
//        let homeResource = NetworkResource()
//        homeResource.getFollowingData(userID: userID) { response in
//            DispatchQueue.main.async {
//                switch response {
//                case .success(let data):
//                    self.delegate?.didReceiveFollowDataResponse(response: data, error: nil)
//
//                case .failure(let error):
//                    self.delegate?.didReceiveFollowDataResponse(response: nil, error: error)
//                }
//            }
//        }
//    }
    func getProfileData(userID: String, requestId: String) {
        let resource = ProfileEditResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userDetails + "?user_id=\(userID)&requested_user_id=\(requestId)"

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
    
    func getUserPostedNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedNews + "?user_id=\(userID)"

        homeResource.getMyNewsData1(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceivePostedNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceivePostedNews(response: nil, error: error)
                }
                
            }
        }
    }
    
    func getUserPostedCases(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userCases + "?user_id=\(userID)"

        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceivePostedCases(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReceivePostedCases(response: nil, error: error)
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
