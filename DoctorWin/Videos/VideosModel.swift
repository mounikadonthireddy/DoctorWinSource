//
//  VideosModel.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import Foundation
struct VideosModel: Codable {
    let id: Int?
    let title: String?
    let video: String?
}
 
struct VideosResponseModel: Codable {
    let status: Bool?
    let clipsResponse: [VideosModel]?
}
