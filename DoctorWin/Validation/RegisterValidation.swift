//
//  RegisterValidation.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation
struct RegisterValidation {

    func Validate(registerRequest: RegisterRequest) -> ValidationResult {
        if(registerRequest.phone_number.isEmpty) {
            return ValidationResult(success: false, error: "User Mobile Number is empty")
        } else if registerRequest.phone_number.count <  10 {
            return ValidationResult(success: false, error: "User Mobile Number is Not Valid")

        } else if registerRequest.username.count <  3 {
            return ValidationResult(success: false, error: "Plese enter a valid User Name")

        }
        return ValidationResult(success: true, error: nil)
    }

}
