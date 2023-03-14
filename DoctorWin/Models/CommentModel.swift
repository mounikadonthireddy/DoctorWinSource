//
//  CommentModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
struct CommentModel: Codable {
    let comment_id : Int?
    let comment, image, name : String?
    
}
struct commentsReponseModel: Codable {
    let is_active: Bool?
    let userDetails: [CommentModel]
}
