//
//  CarrierModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
struct JobResponseModel: Codable {
    let is_active: Bool?
    let jobResponse: [JobModel]?
    let total_pages: Int?
    
}
struct JobModel: Codable {
    let id: Int
    let category: String?
    let min_salary: String?
    let display_status: Int
    let state: String?
    let max_salary: String?
    let min_experince: String?
    let max_experince: String?
    let bookmark_status: Bool?
    let hr_contact: String?
    let monthly_or_anual: String?
    let jobid: String?
    let image: String?
    let eligibility : [EligibilityModel]?
    let name_of_company: String?
    let city: String?
    let Speciality: String?
}
//struct CarrierModel: Codable {
//
//    let designation: String?
//    let Speciality: String?
//
//
//    let monthly_or_anual: String?
//
//    let hr_name: String?
//    let location_of_job: String?
//    let hospital_image: String?
//    let eligibility: [EligibilityModel]
//    let about_company: String?
//
//
//    let name_of_company: String?
//    let name: String?
//    let accommodation: Bool?
//    let job_type: String?
//    let description: String?
//    let gender: String?
//    let website:String?
//    let jobid: String?
//    let city: String?
//
//}

struct EligibilityModel: Codable {
    let name: String
}


