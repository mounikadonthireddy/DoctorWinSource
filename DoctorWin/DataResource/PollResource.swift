//
//  PollResource.swift
//  DoctorWin
//
//  Created by N517325 on 04/12/21.
//

import Foundation

struct PollResource {
    func addPollData(request: AddPollRequestModel, completion : @escaping (_ result: BoolResponseModel?) -> Void) {
        
        let loginUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addPoll
        let loginUrl = URL(string: loginUrlStr)!
        let httpUtility = HttpUtility()
        do {
            

            let loginPostBody = try JSONEncoder().encode(request)
            httpUtility.postMethod(urlString: loginUrlStr, requestBody: loginPostBody, resultType: BoolResponseModel.self) { (loginApiResponse) in

//                _ = completion(loginApiResponse)
           }
        }
        catch let error {
            debugPrint(error)
        }
    }
    func getPollData(userID: String, urlStr:String,completion : @escaping (_ result: ResponseResult<[PollsDataModel]>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlStr, resultType: [PollsDataModel].self) { result in
                
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
