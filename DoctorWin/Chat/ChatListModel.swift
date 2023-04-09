//
//  ChatListModel.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import Foundation

struct ChatListModel: Codable {
    let room_id: String
    let speciality: String?
    let image: String?
    let name: String?
    let phone_number:String?
}
struct ChatHistoryModel: Codable {
    let message: String?
    let data: [ChatModel]?
}
struct ChatModel: Codable {
    let name: String?
    let time: String?
    let message: String?
}
struct ChatMessageModel: Codable {
    let message: [ChatModel]?
}
struct RecentChatModel: Codable {
    let roomid: String?
    let relatedname: String?
    let message: String?
    let image: String?
}
