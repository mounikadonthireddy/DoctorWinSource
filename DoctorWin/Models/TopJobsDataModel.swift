//
//  TopJobsDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 29/10/21.
//

import Foundation
struct JobsDataModel : Codable {
    let companyName : String?
    let experince : Int?
    let id : Int?
    let image: String?
    let location: String?
    let designation: String?
    let date: String?
    let salary: Int?
    let salaryType: String?
    let vacancy : Int?
    let skills: String?
    let accommodation: String?
    let jobType: String?
    let workingHours: String?
    let workingDays : String
    let role : String?
    let jobDiscription: String?
    let hospitalType:  String?
    let totalBeds : Int?
    let icu : Int?
    let nicuc: Int?
    let picu : Int?
    let gender : String?
    let title : String?
    let subTitle: String?
    let qualification : String?
    let course : String?
    let bookmarkStatus: Bool?
    let applyStatus: Bool?

    enum CodingKeys: String, CodingKey {
        case companyName = "hosptial_name"
        case experince
        case id
        case image
        case location
        case designation
        case date = "created_date"
        case salary
        case salaryType = "monthly_or_anual"
        case vacancy
        case skills
        case accommodation
        case jobType = "job_type"
        case workingHours = "working_hours"
        case workingDays = "working_day"
        case role
        case jobDiscription = "discription"
        case hospitalType = "hospital_type"
        case totalBeds = "total_bed"
        case icu
        case nicuc
        case picu
        case gender
        case qualification = "qualification"
        case subTitle = "sub_heading"
        case title = "department"
        case course = "Speciality"
        case bookmarkStatus = "bookmark_status"
        case applyStatus = "apply_status"

    }
}
