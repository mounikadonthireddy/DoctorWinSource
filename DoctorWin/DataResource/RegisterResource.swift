//
//  RegisterResource.swift
//  DoctorWin
//
//  Created by N517325 on 30/11/21.
//

import Foundation
struct RegisterResource {
    func registerUser(registerRequest: RegisterRequest, completion : @escaping (ResponseResult<LoginResponseModel>) -> Void) {
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.register
        let homeUrl = URL(string: loginUrlStr)!

        let httpUtility = HttpUtility()
        do {
            let loginPostBody = try JSONEncoder().encode(registerRequest)
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: loginPostBody, resultType: LoginResponseModel.self) { (result) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
        }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
