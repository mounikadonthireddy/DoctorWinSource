//
//  CarrierModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
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


