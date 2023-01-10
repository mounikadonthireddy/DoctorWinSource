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

        } else if registerRequest.name.count <  3 {
            return ValidationResult(success: false, error: "Please enter your full name")
        }
        else if !isValidEmail(registerRequest.email) {
            return ValidationResult(success: false, error: "Plese enter a valid  Email address")

        } else if registerRequest.speciality.count ==  0 {
            return ValidationResult(success: false, error: "Please Select Speciality")
        } 
        return ValidationResult(success: true, error: nil)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)

}
}
