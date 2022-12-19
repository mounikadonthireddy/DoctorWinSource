//
//  JobDetailsModel.swift
//  DoctorWin
//
//  Created by N517325 on 01/11/21.
//

import Foundation

struct JobDetailsResponseModel: Codable {
    let is_active: Bool?
    let jobResponse: JobDetailsModel?
}

struct JobDetailsModel : Codable {
    let eligibility : String?
    let category: String?
    let max_experince: String?
    let state: String?
    let working_hours: String?
    let qualification: String?
    let description: String?
    let accommodation: Bool?
    let job_type: String?
    let address_of_company: String?
    let website: String?
    let max_salary: String?
    let image: String?
    let monthly_or_anual: String?
    let name_of_company: String?
    let about_company: String?
    let bookmark_status: Bool?
    let apply_status: Bool?
    let min_experince: String?
    let hr_contact: String?
    let city: String?
    let min_salary: String?
    let vacancy: String?
    let posted_by: String?
    let working_days: String?
    let display_status: Int?
    let gender: String?
    let typeofhospital: String?
    let hr_name: String?
    let Speciality: String?
    let created_date: String?
}
