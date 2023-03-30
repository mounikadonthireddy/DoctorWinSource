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
    let description: String?
    let title: String?
}
struct TestimonialResponseModel: Codable {
    let description: [TestimonialModel]?
    let message: String?
    
}

struct DailyUpdatesModel: Codable {
    let description: String?
}
struct DailyUpdatesResponseModel: Codable {
    let description: [DailyUpdatesModel]?
}
struct FAQResponseModel: Codable {
    let description: [FAQModel]?
    let message: String?
}
struct FAQModel: Codable {
    let title: String?
    let description: String?
}
struct MentorPlanResponseModel: Codable {
    let description: [MentorPlanModel]?
    let status: Bool?
}
struct MentorPlanModel: Codable {
    let id: Int?
    let title: String?
    let related_to: String?
    let image: String?
    let description: String?
    
}

struct ServicesResponseModel: Codable {
    let description: [ServiceModel]?
}
struct ServiceModel: Codable {
    let category: String?
    let subcategory: [SubCategory]?
}
struct SubCategory: Codable {
    let name: String?
}
