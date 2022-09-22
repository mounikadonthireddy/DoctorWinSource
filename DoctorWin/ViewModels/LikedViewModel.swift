//
//  SavedViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/06/2565 BE.
//

import Foundation


struct CasesViewModel {
    var delegate: CasesBookMarkDelegate?

    func getCases(userID: String, index: Int) {
        let homeResource = HomeResource()
        var endPoint = ""
        switch index {
        case 0:
            endPoint = ApiEndpoints.postedCases + ApiEndpoints.userID + "=\(userID)"
        case 1:
            endPoint = ApiEndpoints.postedCases + ApiEndpoints.userID + "=\(userID)"
    
        default:
            endPoint = ""
        }
        let homeUrlStr = ApiEndpoints.baseUrl + endPoint 

        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedCases(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReceiveBookmakedCases(response: nil, error: error)
                }
                
            }
        }
    }
    
}

struct NewsDataViewModel {
    var delegate: NewsBookMarkDelegate?

    func getNews(userID: String, index: Int) {
        let homeResource = NewsJobResource()
        var endPoint = ""
        switch index {
        case 0:
            endPoint = ApiEndpoints.postedNews + ApiEndpoints.userID + "=\(userID)"
        case 1:
            endPoint = ApiEndpoints.postedNews + ApiEndpoints.userID + "=\(userID)"
        case 2:
            endPoint = ApiEndpoints.likedNews + ApiEndpoints.userID + "=\(userID)"
        default:
            endPoint = ""
        }
        let homeUrlStr = ApiEndpoints.baseUrl + endPoint 

        homeResource.getMyNewsData1(urlString: homeUrlStr) { response in
              DispatchQueue.main.async {
                  switch response {
                  case .success(let data):
                      self.delegate?.didReceiveBookmakedNews(response: data, error: nil)
                      
                  case .failure(let error):
                      self.delegate?.didReceiveBookmakedNews(response: nil, error: error)
                  }
                  
              }
          }
    }
    
}
