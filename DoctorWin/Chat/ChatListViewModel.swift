//
//  ChatListViewModel.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import Foundation

protocol ChatListViewModelDelegate {
    func didReciveVideosData(response: [ChatListModel]?, error: String?)
}
struct ChatListViewModel {
    var delegate : ChatListViewModelDelegate?
 
    func getChatListDataFromAPI(pageNum: Int) {
        let homeResource = ChatResource()
        homeResource.getProfilesListData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveVideosData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveVideosData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
