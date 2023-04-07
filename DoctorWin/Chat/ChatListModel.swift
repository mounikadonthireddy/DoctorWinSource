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
