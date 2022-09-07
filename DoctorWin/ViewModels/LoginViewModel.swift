//
//  LoginViewModel.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/2020.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    func didReceiveLoginResponse(wilNavigateTo: Bool, error: String?)
    func didValidated(status: Bool, error: String?)
}

struct LoginViewModel {
    var delegate : LoginViewModelDelegate?
    
    func loginUser(loginRequest: LoginRequest) {
        let validationResult = LoginValidation().Validate(loginRequest: loginRequest)
        
        if(validationResult.success) {
            //use loginResource to call login API
            self.delegate?.didValidated(status: true, error: nil)
            
            let loginResource = LoginResource()
            loginResource.loginUser(loginRequest: loginRequest) { (result) in
                
                //return the response we get from loginResource
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if data.status {
                            UserDefaults.standard.setValue(loginRequest.phoneNumber, forKey: "mobileNum")
                            self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: nil)
                        } else if data.status == false && data.Verified == false {
                            self.delegate?.didReceiveLoginResponse(wilNavigateTo: true, error: "register")
                            
                        } else {
                            self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometime")
                            
                        }
                    
                case .failure(_):
                    self.delegate?.didReceiveLoginResponse(wilNavigateTo: false, error: "Please Try again after sometime")
                }
                    
                    
                }
            }
            
        } else {
            DispatchQueue.main.async {
                self.delegate?.didValidated(status: false, error: validationResult.error ?? "")
            }
            
        }
        
    }
}
