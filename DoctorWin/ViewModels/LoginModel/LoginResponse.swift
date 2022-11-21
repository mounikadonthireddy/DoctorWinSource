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
    let message: String?
    let status: Bool
    let Verified: Bool
}
                                                        
struct OTPResponse: Codable {
    let phone_number : String?
    let profile_name: String?
    let dworks_id: String?
    let status: Bool?
    let token: String?
    let message: String?
    let dating_profile_status: Bool?
    

//    let username_status: String
//    let username: String
    
//    "id": 183,
//       "phone_number": "6304763236",
//       "profile_name": "Mounika",
//       "current_job_location": "Hyderabad",
//       "speciality": "Dentistry",
//       "hightest_qualification": "D.ortho",
//       "status": true,
//       "userdetail": 206,
//       "user_id": 206,
//       "email": "test@gmail.com",
//       "username": "Mounika@job27563"
}
