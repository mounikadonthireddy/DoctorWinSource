//
//  DropDownResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/02/22.
//

import Foundation

struct QualificationModel: Codable {
    let qualification: String
    let id: Int
}
struct SpeciltyModel: Codable {
    let department: String
    let id: Int
}
struct DropDownResource {
    
    func getQualificationData(completion : @escaping (_ result: [QualificationModel]) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getQualification
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [QualificationModel].self) { result in
                
                switch result {
                   case .success(let data):
                    completion(data)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
//                        completion(.failure("Please try Again After SomeTime"))
                       break
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
    
    func getSpecilityData(completion : @escaping (_ result: [SpeciltyModel]) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getSpeacilty
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [SpeciltyModel].self) { result in
                
                switch result {
                   case .success(let data):
                    completion(data)
                    
                   case .failure(let requestError):
                       switch requestError {
                       case .invalidUrl:
//                        completion(.failure("Please try Again After SomeTime"))
                       break
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
