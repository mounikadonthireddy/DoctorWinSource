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
    var phone_number: String
    var username: String
//    enum CodingKeys: String, CodingKey {
//        case phoneNumber = "phone_number"
//        case userName = "username"
//    }
}

struct OTPRequest: Encodable {
    let phone_number : String
    let otp: String
//    let username_status: String
//    let username: String
}
