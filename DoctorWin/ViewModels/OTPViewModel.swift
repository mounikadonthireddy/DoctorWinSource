//
//  OTPViewModel.swift
//  DoctorWin
//
//  Created by Mounika on 21/12/21.
//

import Foundation
protocol OTPViewModelDelegate {
    func didReceiveLoginResponse(wilNavigateTo: Bool, error: String?)
}

struct OTPViewModel
{
    var delegate : OTPViewModelDelegate?
    
    func validateOTP(request: OTPRequest) {
        
        let loginResource = LoginResource()
        loginResource.validateOtp(request: request) { (result) in
            DispatchQueue.main.async {
           if result.status {
               User.shared.userID = "\(result.userdetail!)"
               UserDefaults.standard.setValue("\(result.userdetail!)", forKey: "user_id")
               UserDefaults.standard.setValue(result.phone_number, forKey: "mobileNum")
               self.delegate?.didReceiveLoginResponse(wilNavigateTo: true, error: nil)
            }
           else if result.required_field ?? false {
                self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "register")
                
           } else {
               self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometim")

           }
            }
        
        }
    }
    
}

