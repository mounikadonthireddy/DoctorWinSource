//
//  LoginResource.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct LoginResource {

    func loginUser(loginRequest: LoginRequest, completion :  @escaping(LoginResponse) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.login
        let homeUrl = URL(string: loginUrlStr)!

        let httpUtility = HttpUtility()
        do {
            
            let loginPostBody = try JSONEncoder().encode(loginRequest)
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
               
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
    func validateOtp(request: OTPRequest, completion :  @escaping(OTPResponse) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.otp
        let homeUrl = URL(string: loginUrlStr)!

        let httpUtility = APIHelperClass()
        do {
            
            let loginPostBody = try JSONEncoder().encode(request)
            httpUtility.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: loginPostBody, resultType: OTPResponse.self, httpMethod: HTTPMethod.post) { (result) in
                completion(result)
               
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
    
    func resendOtp(request: LoginRequest, completion :  @escaping(LoginResponse) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.resendOtp
        let homeUrl = URL(string: loginUrlStr)!

        let httpUtility = HttpUtility()
        do {
            
            let loginPostBody = try JSONEncoder().encode(request)
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
               
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
