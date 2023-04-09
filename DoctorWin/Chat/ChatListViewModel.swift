//
//  ChatListViewModel.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import Foundation

protocol ChatListViewModelDelegate {
    func didReciveChatListData(response: [ChatListModel]?, error: String?)
    func didReciveRecentChatsData(response: [RecentChatModel]?, error: String?)
}
struct ChatListViewModel {
    var delegate : ChatListViewModelDelegate?
 
    func getChatListDataFromAPI(pageNum: Int) {
        let homeResource = ChatResource()
        homeResource.getProfilesListData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveChatListData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveChatListData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getRecentChatListDataFromAPI(pageNum: Int) {
        let homeResource = ChatResource()
        homeResource.getRecentChatProfilesData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveRecentChatsData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveRecentChatsData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
