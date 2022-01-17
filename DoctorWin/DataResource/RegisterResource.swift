//
//  RegisterResource.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation
struct RegisterResource {
    func registerUser(registerRequest: RegisterRequest, completion : @escaping (Result<LoginResponse, RequestError>) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.login
        let httpUtility = HttpUtility()
        do {
            let loginPostBody = try JSONEncoder().encode(registerRequest)
            httpUtility.postMethod(urlString: loginUrlStr, requestBody: loginPostBody, resultType: LoginResponse.self) { (result) in
                completion(result)
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
