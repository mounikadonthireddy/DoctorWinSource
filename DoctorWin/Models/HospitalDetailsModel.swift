//
//  HospitalDetailsModel.swift
//  DoctorWin
//
//  Created by AHP on 17/06/2565 BE.
//

import Foundation
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

