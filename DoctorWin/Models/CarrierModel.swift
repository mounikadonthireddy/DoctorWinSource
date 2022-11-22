//
//  CarrierModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
struct JobCarrierModel: Codable {
    let next: Bool?
    let data: [CarrierModel]?
    let total_pages: Int?
    
}
struct CarrierModel: Codable {
    let id: Int
    let designation: String?
    let Speciality: String?
    let experince: String?
    let hr_contact: String?
    let monthly_or_anual: String?
    let bookmark: Bool
    let hr_name: String?
    let location_of_job: String?
    let hospital_image: String?
    let eligibility: [EligibilityModel]
    let about_company: String?
    let max_salary: String?
    let min_salary: String?
    let name_of_company: String?
    let name: String?
    let accommodation: Bool?
    let job_type: String?
    let description: String?
    let gender: String?
    let website:String?
    let jobid: String?
    let city: String?
    let state: String?
}

struct EligibilityModel: Codable {
    let name: String
}


