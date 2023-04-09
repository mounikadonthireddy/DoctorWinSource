//
//  ChatResource.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import Foundation
struct ChatResource {
    func getProfilesListData(pageNum: Int, completion : @escaping (_ result: ResponseResult<[ChatListModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.chatList
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ChatListModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
    func getRecentChatProfilesData(pageNum: Int, completion : @escaping (_ result: ResponseResult<[RecentChatModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.recentChatList
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [RecentChatModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
        }
        
    }
}
