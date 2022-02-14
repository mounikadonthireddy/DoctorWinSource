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
    func getLocationData(completion : @escaping (_ result: [LocationModel]) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getJobsLocation
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [LocationModel].self) { result in
                
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
    func getDesignationData(completion : @escaping (_ result: [DesignationModel]) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getDesignation
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [DesignationModel].self) { result in
                
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
    //getRecentSearchData
    func getRecentSearchData(completion : @escaping (_ result: [RecentSearchModel]) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.recentSearch + "?user_id=\(User.shared.userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [RecentSearchModel].self) { result in
                
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
    
    func getJobsCount(completion : @escaping (_ result: JobsCountModel) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobsCount + "?user_id=\(User.shared.userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: JobsCountModel.self) { result in
                
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

struct LocationModel: Codable {
    let location: String
    let id: Int
}
struct DesignationModel: Codable {
    let position: String
    let id: Int
}
struct RecentSearchModel: Codable {
    let search: SearchDataModel
    let id: Int
    let created: String?
}
struct SearchDataModel: Codable {
    let location: String
    let department: String
    let disignation: String
    let id: String
}
struct JobsCountModel: Codable {
    let save_jobs: Int
    let apply_job: Int
}
