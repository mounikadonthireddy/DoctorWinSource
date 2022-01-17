//
//  AddCustomJobResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 28/12/21.
//

import Foundation
class AddCustomJobResource {
func addCustomJobRequest(request: CreateCustomJobModel,userId: String, completion  : @escaping (_ result: ResponseResult<ResponseModel>) -> Void) {
    let urlStr = ApiEndpoints.baseUrl + ApiEndpoints.customJobs + "?user_id=\(userId)"
    let httpUtility = HttpUtility()
    do {
        
        let postBody = try JSONEncoder().encode(request)

        httpUtility.postMethod(urlString: urlStr, requestBody: postBody, resultType: ResponseModel.self) { (result) in

            switch result {
               case .success(let data):
                completion(.success(data))
                
               case .failure(let requestError):
                   switch requestError {
                   case .invalidUrl:
                    completion(.failure("Please try Again After SomeTime"))
                   
                   case .internalServerError:
                    completion(.failure("Please try Again After SomeTime"))

                   
                   case .decodingError:
                    completion(.failure("Please try Again After SomeTime"))

                   case .serverError(error: let error):
                    completion(.failure("Please try Again After SomeTime"))

                   }
               }
        }
    } catch let error {
        print("error is \(error)")
    }
}
    func getDropDownData(userID: String, completion : @escaping (_ result: ResponseResult<CustomJobModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.customJobs 
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: CustomJobModel.self) { result in
                
                switch result {
                   case .success(let data):
                    completion(.success(data))
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
                        completion(.failure("Please try Again After SomeTime"))
                       
                       case .internalServerError:
                        print("Error: Unknown")
                       
                       case .decodingError:
                        print("Error: Unknown")
                       case .serverError(error: let error):
                        print("Error: Unknown")
                       }
                   }
            }
        }
    }
}
