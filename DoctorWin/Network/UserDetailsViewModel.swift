//
//  UserDetailsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import Foundation

protocol UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileDataModel?, error: String?)
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?)
    func didRecivePostsData(response: [HomeDataModel]?, error: String?)
    func didReciveCasesData(response: [CasesDataModel]?, error: String?)
    func didReciveQuestionsData(response: [PostedQuestionModel]?, error: String?)
    func didReciveAnswersData(response: [AnswersModel]?, error: String?)
}

struct UserDetailsViewModel {
    var delegate : UserDetailsViewModelDelegate?
    func getProfileData(userID: String) {
        let resource = ProfileEditResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"

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
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNetworkConnections + "?user_id=\(userID)&group_id=\(groupId)"

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
    func getHomeData(userId: String, group_id: String) {
    
        
    }
    func getPostData(userID: String, group_id: String? = nil) {
        let homeResource = UserDetailsResource()
        var endUrl  = ""
        if let groupId = group_id {
            endUrl  = "&group_id=\(groupId)"
        }
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getUserPostedPosts + "?user_id=\(userID)&page=1" + "\(endUrl)"

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
    func getCasesData(userID: String, group_id: String? = nil) {
        let homeResource = UserDetailsResource()
        var endUrl  = ""
        if let groupId = group_id {
            endUrl  = "&group_id=\(groupId)"
        }
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getUserPostedCases + "?user_id=\(userID)&page=1" + endUrl

        homeResource.getUserPostedCasesData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveCasesData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveCasesData(response: nil, error: error)
                }
                
            }
        }
    }
    func getQuestionsData(userID: String, group_id: String? = nil) {
        let homeResource = UserDetailsResource()
        var endUrl  = ""
        if let groupId = group_id {
            endUrl  = "&group_id=\(groupId)"
        }
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getUserPostedQuestions + "?user_id=\(userID)&page=1" + endUrl

        homeResource.getUserPostedQuestionsData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveQuestionsData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveQuestionsData(response: nil, error: error)
                }
                
            }
        }
    }
    func getAnswersData(userID: String, group_id: String? = nil) {
        let homeResource = UserDetailsResource()
        var endUrl  = ""
        if let groupId = group_id {
            endUrl  = "&group_id=\(groupId)&page=1"
        }
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getUserPostedAnswers + "?selfid=\(userID)" + endUrl

        homeResource.getUserPostedAnswersData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveAnswersData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveAnswersData(response: nil, error: error)
                }
                
            }
        }
    }
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
//        let homeResource = NewsJobResource()
//        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedNews + "?user_id=\(userID)"
//
//        homeResource.getMyNewsData1(urlString: homeUrlStr) { response in
//            DispatchQueue.main.async {
//                switch response {
//                case .success(let data):
//                    self.delegate?.didReceivePostedNews(response: data, error: nil)
//
//                case .failure(let error):
//                    self.delegate?.didReceivePostedNews(response: nil, error: error)
//                }
//
//            }
//        }
    }
    
    func getUserPostedCases(userID: String) {
//        let homeResource = HomeResource()
//        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userCases + "?user_id=\(userID)"
//
//        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
//            DispatchQueue.main.async {
//                switch response {
//                case .success(let data):
//                    self.delegate?.didReceivePostedCases(response: data, error: nil)
//
//                case .failure(let error):
//                    self.delegate?.didReceivePostedCases(response: nil, error: error)
//                }
//
//            }
//        }
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
    let name_of_group: String?
    let description: String?
    let image: String?
    let cover_image: String?
    let join_status: Bool?
    let number_of_joined: Int?
    let group_joined_image: [GenderImageModel]?
    let profileImage: String?
    
}
