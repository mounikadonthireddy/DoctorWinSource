//
//  BookMarkViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/06/2565 BE.
//

import Foundation

protocol JobsBookMarkDelegate {
    func didReceiveBookmakedJobs(response: [CarrierModel]?, error: String?)
}
protocol CasesBookMarkDelegate {
    func didReceiveBookmakedCases(response: [CasesDataModel]?, error: String?)
}
protocol NewsBookMarkDelegate {
    func didReceiveBookmakedNews(response: [NewsModel]?, error: String?)
}
protocol ArticleBookMarkDelegate {
    func didReceiveBookmakedArticles(response: [ArticalsDataModel]?, error: String?)
}
protocol ClassiFieldBookmarkDelegate {
    func didReceiveBookmakedClassicfield(response: [CarrierModel]?, error: String?)
}

protocol BookMarkDelegate: JobBookmarkedDelegate & CasesBookMarkDelegate & NewsBookMarkDelegate & ArticleBookMarkDelegate & ClassiFieldBookmarkDelegate {
    
}
struct BookMarkViewModel {
    var delegate : BookMarkDelegate?
    
    func getBookMarkedJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getBookmarkedJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveBookmakedJobs(response: nil, error: error)
                }
            }
        }
    }
    func getBookmarkNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkNews + "?user_id=\(userID)"
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
    func getBookmarkArticles(userID: String) {
        let homeResource = ArticalResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkArtical + "?user_id=\(userID)"

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
    
    func getBookmarkCases(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkCases + "?user_id=\(userID)"

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
