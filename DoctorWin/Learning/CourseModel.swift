//
//  CourseModel.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import Foundation

struct CoursesModel: Codable {
    let name: String?
    let course: [CourseModel]?
}
struct FellowshipResponseModel: Codable {
    let subcategoryResponse: [FellowshipModel]?
    let is_active: Bool?
}
struct FellowshipModel: Codable {
    let image: String?
    let subcategory: String?
}
struct CourseModel: Codable {
    let id: Int
    let category: String?
    let image: String?
    let name: String?
    let subcategory: String?
    let duration: String?
    let video:Int?
    let topics: Int?
}
struct LearningResponseModel: Codable {
    let is_active: Bool?
    let learnResponse: [LearningModel]?
}
struct LearningModel: Codable {
    let suggest: String?
    let subjects: [CourseModel]?
}
struct ElearningBannerModel: Codable {
    let id: Int
    let app_name: String?
    let image: String?
    
}
struct CourseDetailsResponseModel: Codable {
    let is_active : Bool
    let learnResponse: CourseDetailsModel?
}
struct CourseDetailsModel: Codable {
    let demo_video: String?
    let subject: SubjectModel?
    let overView: OverViewModel?
    let Curriculum:[CurriculamModel]?
    let buy: [BuyModel]?
}
struct SubjectModel: Codable {
    let id: Int?
    let name:String?
    let description: String?
    let video: Int?
    let duration: String?
}
struct OverViewModel: Codable {
    let description: String?
    let heightlight: String?
}
struct CurriculamModel: Codable {
    let id: Int?
    let name:String?
    let duration: String?
    let total_lession: Int?
    let lession: [SubChaperModel]?
}
struct SubChaperModel: Codable {
    let id: Int?
    let name: String?
    let video: String?
    let duration: String?
}
struct BuyModel: Codable {
    let name: String?
    let description: String?
    let price: Int?
}
struct CoursesCategoryResponseModel: Codable {
    let is_active: Bool?
    let learnResponse: [CoursesCategoryModel]?
}
struct CoursesCategoryModel: Codable {
    let name_of_course: String?
    let id: Int
    let image: String?
}
struct CategoryModel: Codable {
    let course: [CoursesCategoryModel]
    
}
struct LearningCategoryResponseModel: Codable {
    let is_active: Bool?
    let learnResponse: [LearningCategoryModel]?
}
struct LearningCategoryModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let image: String?
    let original_price: String?
    let offer_price: String?
    let videos: Int?
    let duration: String?
    let percentage_off: Int?
    let subcategory: String?
}
