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
            endPoint = ApiEndpoints.postedCases
        case 1:
            endPoint = ApiEndpoints.bookmarkCases
        case 2:
            endPoint = ApiEndpoints.likedCases
        default:
            endPoint = ""
        }
        let homeUrlStr = ApiEndpoints.baseUrl + endPoint + "?user_id=\(userID)"

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
            endPoint = ApiEndpoints.postedNews
        case 1:
            endPoint = ApiEndpoints.bookmarkNews
        case 2:
            endPoint = ApiEndpoints.likedNews
        default:
            endPoint = ""
        }
        let homeUrlStr = ApiEndpoints.baseUrl + endPoint + "?user_id=\(userID)"

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
struct ArticlesDataViewModel {
    var delegate: ArticleBookMarkDelegate?
    func getArticles(userID: String, index: Int) {
        let homeResource = ArticalResource()
        var endPoint = ""
        switch index {
        case 0:
            endPoint = ApiEndpoints.postedArtical
        case 1:
            endPoint = ApiEndpoints.bookmarkArtical
        case 2:
            endPoint = ApiEndpoints.likedArtical
        default:
            endPoint = ""
        }
        let homeUrlStr = ApiEndpoints.baseUrl + endPoint + "?user_id=\(userID)"

        homeResource.getArticalData(userID: userID, urlStr: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedArticles(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveBookmakedArticles(response: nil, error: error)
                }
                
            }
        }
    }
    
}
