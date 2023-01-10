//
//  OTPViewModel.swift
//  DoctorWin
//
//  Created by Mounika on 21/12/21.
//

import Foundation

struct OTPViewModel {
    var delegate : RegisterViewModelDelegate?
    
    func validateOTP(request: OTPRequest) {
        
        let loginResource = LoginResource()
        loginResource.validateOtp(request: request) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                        self.delegate?.didReceiveRegsiterResponse(userData: data.userDetails, error: nil)
                        
                    } else {
                        self.delegate?.didReceiveRegsiterResponse(userData: nil, error: "error")
                    }
                case .failure(let error):
                    
                    self.delegate?.didReceiveRegsiterResponse(userData: nil, error: error)
                }
                
            }
            
        }
        
    }
}
