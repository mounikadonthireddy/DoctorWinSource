//
//  NewsViewModel.swift
//  DoctorWin
//
//  Created by Mounika on 22/12/21.
//

import Foundation
protocol NewsViewModelDelegate {
    func didReceiveNews(response: [NewsDataModel]?, error: String?)
    func didReceiveNewsCategory(response: [NewsCategoryModel]?, error: String?)
    func didReceivePageNews(response: [NewscategoryDataModel]?, error: String?)

}

struct NewsViewModel {
    var delegate : NewsViewModelDelegate?
    func getNews(userID: String) {
        let homeResource = NewsJobResource()

        homeResource.getNewsData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNews(response: nil, error: error)
                }
                
            }
        }
    }
    func getNews(userID: String, pageId: Int) {
        let homeResource = NewsJobResource()

        homeResource.getNewsCategoryData(userID: userID,pageId: pageId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceivePageNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceivePageNews(response: nil, error: error)
                }
                
            }
        }
    }
    func getMyNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedNews + "?user_id=\(userID)"

        homeResource.getMyNewsData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNews(response: nil, error: error)
                }
                
            }
        }
    }
    func getLikedNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likedNews + "?user_id=\(userID)"

        homeResource.getMyNewsData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNews(response: nil, error: error)
                }
                
            }
        }
    }
    func getBookmarkNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkNews + "?user_id=\(userID)"

        homeResource.getMyNewsData(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNews(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNews(response: nil, error: error)
                }
                
            }
        }
    }
   
    func getNewsCategory() {
        let homeResource = NewsJobResource()
        homeResource.getNewsCategory() { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveNewsCategory(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveNewsCategory(response: nil, error: error)
                }
                
            }
        }
    }
}
