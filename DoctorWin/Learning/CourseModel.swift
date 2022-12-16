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
struct CourseDetailsModel: Codable {
    let id: Int
    let subject_title: String?
    let lecture_creater_name: String?
    let image: String?
    let discription: String?
    let heightlight_of_subcourse: String?
    let options: String?
    let rating: String?
    let department: String?
    let video: String?
    let original_price:String?
    let offer_price: String?
    let validity: String?
    let course: String?
    let number_of_lession: Int?
}

struct CurriculamModel: Codable {
    let id: Int
    let chapter_name:String?
    let duration: String?
    let number_of_subtopic: Int?
    let sub_chapter: [SubChaperModel]?
}
struct SubChaperModel: Codable {
    let id: Int
    let sub_chapter_name: String?
    let video: String?
    let duration: String?
}
struct CoursesCategoryResponseModel: Codable {
    let is_active: Bool?
    let learnResponse: [CoursesCategoryModel]?
}
struct CoursesCategoryModel: Codable {
    let name_of_course: String?
    let id: Int
}
struct CategoryModel: Codable {
    let course: [CoursesCategoryModel]
    
}
struct LearningCategoryModel: Codable {
    let id: Int
    let subject_title: String?
    let lecture_creater_name: String?
    let image: String?
    let options: String?
    let rating: String?
    let department: String?
    let original_price: String?
    let offer_price: String?
    let validity: String?
    let number_of_lession: Int?
}
