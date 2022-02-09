//
//  LoginRequest.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct LoginRequest : Encodable {
    var phoneNumber: String
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
    }
}
struct RegisterRequest : Encodable {
    let phoneNumber: String
    let name: String
    let email: String
    let qualification: String
    let currentLocation: String
    let speciality: String
    
    enum CodingKeys: String,CodingKey {
        case phoneNumber = "phone_number"
        case name = "profile_name"
        case email  = "email"
        case qualification = "hightest_qualification"
        case currentLocation = "current_job_location"
        case speciality = "speciality"
    }
}

struct OTPRequest: Encodable {
    let phone_number : String
    let otp: String
//    let username_status: String
//    let username: String
}
