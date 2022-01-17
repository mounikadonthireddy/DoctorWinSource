//
//  CustomJobModel.swift
//  DoctorWin
//
//  Created by N517325 on 13/11/21.
//

import Foundation
struct CustomJobModel: Codable {
    let hospitalArray: [String]?
    let positionArray: [String]?
    let departmentArray: [String]?
    let salaryArray: [Int]?
    let jobTypeArray: [String]?
    let locationArray: [String]?
    let vacancyArray: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case hospitalArray = "type_of_hospital"
        case positionArray = "postion_of_job"
        case departmentArray = "department"
        case salaryArray = "minimum_salary"
        case jobTypeArray = "job_type"
        case locationArray = "city_of_hospital"
        case vacancyArray = "work_experince"


    }
}
