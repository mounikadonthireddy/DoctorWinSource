//
//  DropDownResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/02/22.
//

import Foundation
struct SpeciltyResponseModel: Codable {
    let is_active: Bool?
    let jobResponse: [SpeciltyModel]?
}

struct SpeciltyModel: Codable {
    let Speciality: String
}
struct DropDownResource {
 
    func getSpecilityData(completion : @escaping (_ result: ResponseResult<[SpeciltyModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getSpeacilty + "?search=speciality"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: SpeciltyResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                        completion(.success(data.jobResponse ?? []))
                    } else {
                        completion(.failure(""))
                    }
                  
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getLocationData(completion : @escaping (_ result: ResponseResult<[LocationModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getJobsLocation
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [LocationModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getDesignationData(completion : @escaping (_ result: ResponseResult<[DesignationModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getDesignation
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [DesignationModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    //getRecentSearchData
    func getRecentSearchData(completion : @escaping (_ result: ResponseResult<[RecentSearchModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.recentSearch + ApiEndpoints.userID + "=\(User.shared.userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [RecentSearchModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    
    func getJobsCount(completion : @escaping (_ result: ResponseResult<JobsCountModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.jobsCount + ApiEndpoints.userID + "=\(User.shared.userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: JobsCountModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
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
