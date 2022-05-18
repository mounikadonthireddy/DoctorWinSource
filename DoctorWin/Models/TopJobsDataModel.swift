//
//  TopJobsDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 29/10/21.
//

import Foundation
struct JobsDataModel : Codable {
    let companyName : String?
    let experince : String?
    let id : Int?
    let image: String?
    let location: String?
    let designation: String?
    let date: String?
    let salary: String?
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
    let speciality: String?

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
        case speciality

    }
}


struct CarrierModel: Codable {
    let id: Int
    let designation: String
    let Speciality: String
    let hospital: Int
    let salary: String
    let experince: String
    let hr_contact: String
    let monthly_or_anual: String
    let bookmark: Bool
    let name: String
    let location: String
    let hospital_image: String?
    let eligibility: [EligibilityModel]
}

struct EligibilityModel: Codable {
    let name: String
}


struct HospitalDetailsModel: Codable {
    let name: String?
    let typeofhospital: String?
    let city, state: String?
    let location: String?
    let no_of_OT: String?
    let no_of_sepeciality: String?
    let no_of_bed: String?
    let daily_OPD: String?
    let icu, nicuc, picu: Int?
    let hospitalBanner: [Hospitalbanner]?
    let hospitalhighlight: [Hospitalhighlight]?
    let hospitalspeciality: [Hospitalspeciality]?
    
}
struct Hospitalbanner: Codable {
    let id: Int?
    let image: String?
    
}
struct Hospitalhighlight: Codable {
    let id: Int?
    let title: String?
    let image: String?
}

struct Hospitalspeciality: Codable {
    let id: Int?
    let title: String?
    let image: String?
}

struct CarrierJobDetailsModel: Codable {
    let gender: String?
    let designation: String?
    let Speciality: String?
    let name: String?
    let location: String?
    let accommodation: String?
    let job_type: String?
    let discription: String?
    let apply_status: Bool?
    let experince: String?
    let salary, monthly_or_anual: String?

}
