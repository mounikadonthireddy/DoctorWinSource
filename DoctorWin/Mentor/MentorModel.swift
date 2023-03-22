//
//  MentorModel.swift
//  DoctorWin
//
//  Created by AHP on 21/03/2566 BE.
//

import Foundation

struct TestimonialModel: Codable {
    let image: String?
    let id: Int?
    let message: String?
    let name: String?
}
struct TestimonialResponseModel: Codable {
    let description: [TestimonialModel]?
    let message: String?
    
}

struct DailyUpdatesModel: Codable {
    let message: String?
}
struct DailyUpdatesResponseModel: Codable {
    let description: [DailyUpdatesModel]?
}
