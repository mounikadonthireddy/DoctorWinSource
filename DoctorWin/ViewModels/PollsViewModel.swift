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
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.postedPoll + ApiEndpoints.userID + "=\(userID)"

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
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.pollLike + ApiEndpoints.userID + "=\(userID)"

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
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.pollBookmark + ApiEndpoints.userID + "=\(userID)"

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
