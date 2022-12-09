//
//  OTPViewModel.swift
//  DoctorWin
//
//  Created by Mounika on 21/12/21.
//

import Foundation
enum NavigationScreen {
    case register
    case profileImage
    case coverImage
    case home
    case none
}

protocol OTPViewModelDelegate {
    func didReceiveLoginResponse(wilNavigateTo: NavigationScreen, error: String?)
}

struct OTPViewModel {
    var delegate : OTPViewModelDelegate?
    
    func validateOTP(request: OTPRequest) {
        
        let loginResource = LoginResource()
        loginResource.validateOtp(request: request) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data ):
                    if data.is_active {
                        if let details = data.userDetails {
                            User.shared.token = details.token ?? ""
                            if details.profile_image == false {
                                self.delegate?.didReceiveLoginResponse(wilNavigateTo: .profileImage, error: nil)
                            } else if details.cover_image == false {
                                if details.profile_image == false {
                                    self.delegate?.didReceiveLoginResponse(wilNavigateTo: .coverImage, error: nil)
                                }
                            } else {
                                self.delegate?.didReceiveLoginResponse(wilNavigateTo: .home, error: nil)
                            }
                            
                        }
                    } else if data.is_active == false {
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: NavigationScreen.register, error: "Please Enter")
                        
                    } else {
                        self.delegate?.didReceiveLoginResponse(wilNavigateTo: .none, error: "Please Try again after sometime")
                        
                    }
                case .failure( _):
                    self.delegate?.didReceiveLoginResponse(wilNavigateTo: .none, error: "Please Try again after sometime")
                }
                
            }
        }
        
    }
    
}
