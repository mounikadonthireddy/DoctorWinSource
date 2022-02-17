//
//  PollsViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/01/22.
//

import Foundation
protocol PollsViewModelDelegate {
    func didReceiveNews(response: [PollsDataModel]?, error: String?)
}

struct PollsViewModel {
    var delegate : PollsViewModelDelegate?

    func getMyPolls(userID: String) {
        let homeResource = PollResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedPoll + "?user_id=\(userID)"

        homeResource.getPollData(userID: userID, urlStr: homeUrlStr) { response in
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
    func getLikedPolls(userID: String) {
        let homeResource = PollResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.pollLike + "?user_id=\(userID)"

        homeResource.getPollData(userID: userID, urlStr: homeUrlStr) { response in
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
    func getBookmarkPolls(userID: String) {
        let homeResource = PollResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.pollBookmark + "?user_id=\(userID)"

        homeResource.getPollData(userID: userID, urlStr: homeUrlStr) { response in
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
}
protocol ArticalViewModelDelegate {
    func didReceiveArtical(response: [ArticalsDataModel]?, error: String?)
}
struct ArticalViewModel {
    var delegate : ArticalViewModelDelegate?

    func getMyNews(userID: String) {
        let homeResource = ArticalResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedArtical + "?user_id=\(userID)"

        homeResource.getArticalData(userID: userID, urlStr: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveArtical(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveArtical(response: nil, error: error)
                }
                
            }
        }
    }
    func getLikedNews(userID: String) {
        let homeResource = ArticalResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.likedArtical + "?user_id=\(userID)"

        homeResource.getArticalData(userID: userID, urlStr: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveArtical(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveArtical(response: nil, error: error)
                }
                
            }
        }
    }
    func getBookmarkNews(userID: String) {
        let homeResource = ArticalResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkArtical + "?user_id=\(userID)"

        homeResource.getArticalData(userID: userID, urlStr: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveArtical(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveArtical(response: nil, error: error)
                }
                
            }
        }
    }
}
