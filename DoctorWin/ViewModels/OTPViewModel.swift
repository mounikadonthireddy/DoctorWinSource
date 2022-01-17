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
            
            //return the response we get from loginResource
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    
                    if data.status {
                        User.shared.userID = "\(data.userdetail!)"
                        UserDefaults.standard.setValue("\(data.userdetail!)", forKey: "user_id")
                        UserDefaults.standard.setValue(data.phone_number, forKey: "mobileNum")
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: true, error: nil)
                    }
                    
                    if data.required_field ?? false {
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "register")
                        
                    }
                    
                    
                case .failure( _):
                    self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometim")
                }
            }
        }
    }
    
}

