//
//  HomeViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 18/11/21.
//

import Foundation

protocol DataSavageProtocol {
    func didAddedToWishlist(status:Bool?, error: String?)
    func didAddedToFollow(status:Bool, error: String?)
    func didAddedToSave(status:Bool, error: String?)
    func didReplySent(status:Bool, error: String?)

}

protocol HomeViewModelDelegate {
    func didReciveHomeData(response: [HomeDataModel]?, error: String?)
}

struct HomeViewModel {
    var delegate : HomeViewModelDelegate?
    var savedelegate : DataSavageProtocol?
    func getNewsPollArticleComplaintDataFromAPI(userID: String, pageNum: Int) {
        let homeResource = HomeResource()
        homeResource.getHomeData(userID: userID, pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveHomeData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveHomeData(response: nil, error: error)
                }
            
            }
            
        }
    }
    func saveToWishlist(userID: String, categeroyID: String) {
       
        let homeResource = HomeResource()
        let model = ComplaintLikeModel(user_id: userID, complaint_id: categeroyID)
        homeResource.saveComplaintToWishslist(userID: userID, complaintID: categeroyID, reqModel: model) { response in
            DispatchQueue.main.async {
                if response.status == "true" {
                    self.savedelegate?.didReplySent(status: true, error: nil)
                } else {
                    self.savedelegate?.didReplySent(status: false, error: "error")
                }
            
            }
            
        }
          
        
    }
    func saveToBookMark(userID: String, categeroyID: String) {
       
        let homeResource = HomeResource()
        let model = ComplaintLikeModel(user_id: userID, complaint_id: categeroyID)
        homeResource.saveComplaintToBookmark(userID: userID, complaintID: categeroyID, reqModel: model) { response in
            DispatchQueue.main.async {
                
                if response != nil {
//                    self.delegate?.didAddedToWishlist(status: response, error: nil)
                } else {
             
                    self.savedelegate?.didAddedToWishlist(status: nil, error: nil)
                }
            
            }
            
        }
        
    }
    
   
    func getAllCases(userID: String) {
//        let homeResource = HomeResource()
//        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedCases + "?user_id=\(userID)"
//
//        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
//            DispatchQueue.main.async {
////                switch response {
////                case .success(let data):
////                    self.delegate?.didReciveHomeData(response: data, error: nil)
////
////                case .failure(let error):
////                    self.delegate?.didReciveHomeData(response: nil, error: error)
////                }
////
//            }
//        }
    }
    func getLikedCases(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likedCases + "?user_id=\(userID)"

        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
//                switch response {
              //  case .success(let data):
                   // self.delegate?.didReciveHomeData(response: data, error: nil)//

             //   case .failure(let error):
                   // self.delegate?.didReciveHomeData(response: nil, error: error)
              //  }
                
            }
        }
    }
}
struct ComplaintLikeModel: Codable {
    let user_id : String
    let complaint_id: String
}
