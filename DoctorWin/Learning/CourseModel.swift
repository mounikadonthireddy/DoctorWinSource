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
    let subject_title: String?
    let image: String?
    let rating: String?
    let department: String?
    let duration: String?
    let number_of_lession:Int?
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
