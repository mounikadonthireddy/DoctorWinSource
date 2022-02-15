//
//  RegisterResource.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation
struct RegisterResource {
    func registerUser(registerRequest: RegisterRequest, completion : @escaping (LoginResponse) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.login
        let homeUrl = URL(string: loginUrlStr)!

        let httpUtility = HttpUtility()
        do {
            let loginPostBody = try JSONEncoder().encode(registerRequest)
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
