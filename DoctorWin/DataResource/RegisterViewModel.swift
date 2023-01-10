//
//  RegisterViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation

protocol RegisterViewModelDelegate {
    func didReceiveRegsiterResponse(userData: LoginUserDetails?, error: String?)
}

struct RegisterViewModel {
    var delegate : RegisterViewModelDelegate?
    
    func registerUser(registerRequest: RegisterRequest) {
//        let validationResult = RegisterValidation().Validate(registerRequest: registerRequest)
//
//        if(validationResult.success) {
//            self.delegate?.didValidated(status: true, error: nil)
            
            //use loginResource to call login API
            let registerResource = RegisterResource()
            registerResource.registerUser(registerRequest: registerRequest) { (result) in
                
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
//        } else {
//            DispatchQueue.main.async {
//                self.delegate?.didValidated(status: false, error: validationResult.error ?? "")
//            }
            
//        }
    }
}

