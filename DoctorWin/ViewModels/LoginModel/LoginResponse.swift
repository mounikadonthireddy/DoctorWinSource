//
//  Login.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/2020.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

//struct LoginResponse : Decodable {
//
//    let errorMessage: String?
//    let data: LoginResponseData?
//}

struct LoginResponse : Decodable {
    let messaage: String?
    let status: Bool
    let otp: Int?
    let user_status: Bool?
    let userdetail: Int?
    let required_field: Bool?
    let message: String?
    let phone_number: String?
    let username : String?
    let username_status: Bool?
}
                                                        
