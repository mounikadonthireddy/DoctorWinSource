//
//  LoginResource.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct LoginResource {

    func loginUser(loginRequest: LoginRequest, completion :  @escaping(Result<LoginResponse, RequestError>) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.login
        let httpUtility = HttpUtility()
        do {
            
            let loginPostBody = try JSONEncoder().encode(loginRequest)
            httpUtility.postMethod(urlString: loginUrlStr, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
               
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
    func validateOtp(request: OTPRequest, completion :  @escaping(Result<LoginResponse, RequestError>) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.otp
        let httpUtility = HttpUtility()
        do {
            
            let loginPostBody = try JSONEncoder().encode(request)
            httpUtility.postMethod(urlString: loginUrlStr, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
               
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
