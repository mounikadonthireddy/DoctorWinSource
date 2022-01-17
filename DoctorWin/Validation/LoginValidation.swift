//
//  LoginValidation.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct LoginValidation {

    func Validate(loginRequest: LoginRequest) -> ValidationResult
    {
        if(loginRequest.phoneNumber.isEmpty) {
            return ValidationResult(success: false, error: "User Mobile Number is empty")
        } else if loginRequest.phoneNumber.count <  10 {
            return ValidationResult(success: false, error: "User Mobile Number is Not Valid")

        }
        return ValidationResult(success: true, error: nil)
    }

}
