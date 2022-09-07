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

struct OTPViewModel {
    var delegate : OTPViewModelDelegate?
    
    func validateOTP(request: OTPRequest) {
        
        let loginResource = LoginResource()
        loginResource.validateOtp(request: request) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data ):
                    
                    if data.status ?? false {
                        User.shared.userID = "\(data.user_id!)"
                        UserDefaults.standard.setValue("\(data.user_id!)", forKey: "user_id")
                        UserDefaults.standard.setValue(data.phone_number, forKey: "mobileNum")
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: true, error: nil)
                    }
                    else if data.message != nil {
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Enter")
                        
                    } else {
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometime")
                        
                    }
                case .failure( _):
                    self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometime")
                }
                
            }
        }
        
    }
    
}
