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
}
