//
//  Login.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/2020.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct LoginResponseModel: Codable {
    let message: String
    let is_active: Bool
    let userDetails: LoginUserDetails?
}
struct LoginUserDetails: Codable {
    let phone_number: String?
    let name: String?
    let dating_profile_status : Bool?
    let cover_image: Bool?
    let profile_image: Bool?
    let token: String?
}
