//
//  CollegeDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import Foundation

struct CollegeDataModel: Codable {
    
    let collegeName : String?
    let universityName : String?
    let annualFree : Int?
    let city: String?
    let district: String?
    let state: String?
    let pincode : Int?
    let examinationArray: [ExaminationModel]
    let seats : Int?
    let nationalRanking: Int?
    let image: String?
    let courseArray: [CourseModel]
    let aboutUs : String?
    let autonomus : String?
    let establishmentYear : String?
    let totalStaff : Int?
    let cutoffMarks : Int?
    let lastYearRank : Int?
    let stateRank: Int?


    enum CodingKeys: String, CodingKey {
        case collegeName  = "name"
        case universityName = "university"
        case annualFree = "annual_free"
        case city
        case district
        case state
        case pincode
        case examinationArray = "Examination"
        case seats = "sit"
        case nationalRanking = "national_ranking"
        case image
        case courseArray = "Course"
        case aboutUs = "about_college"
        case autonomus
        case establishmentYear = "establishment"
        case totalStaff = "staff"
        case cutoffMarks = "cutoff"
        case lastYearRank = "last_year_rank"
        case stateRank  = "state_ranking"

    }
}

struct ExaminationModel : Codable {
    let name : String?
}
struct CourseModel : Codable {
    let name : String?
}
