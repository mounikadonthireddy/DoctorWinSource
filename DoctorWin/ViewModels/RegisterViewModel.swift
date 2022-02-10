//
//  RegisterViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation

protocol RegisterViewModelDelegate {
    func didReceiveRegsiterResponse(wilNavigateTo: Bool, error: String?)
    func didValidated(status: Bool, error: String?)

}

struct RegisterViewModel {
    var delegate : RegisterViewModelDelegate?

    func registerUser(registerRequest: RegisterRequest) {
        let validationResult = RegisterValidation().Validate(registerRequest: registerRequest)

        if(validationResult.success) {
            self.delegate?.didValidated(status: true, error: nil)

            //use loginResource to call login API
            let registerResource = RegisterResource()
            registerResource.registerUser(registerRequest: registerRequest) { (result) in

                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        
                        if data.message == "Otp sented Successful" {
                            
                            UserDefaults.standard.setValue("\(registerRequest.name)", forKey: "username")
                            UserDefaults.standard.setValue(registerRequest.phoneNumber, forKey: "mobileNum")
                            self.delegate?.didReceiveRegsiterResponse(wilNavigateTo: false, error: nil)
                        }
                        
                        if data.required_field ?? false {
                            self.delegate?.didReceiveRegsiterResponse(wilNavigateTo: true, error: "register")
                            
                        }
                        
                        
                    case .failure( _):
                        self.delegate?.didReceiveRegsiterResponse(wilNavigateTo: false, error: "Please Try again after sometim")
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

