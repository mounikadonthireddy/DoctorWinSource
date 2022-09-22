//
//  DropDownResource.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/02/22.
//

import Foundation
struct ProfessionModel: Codable {
    let position: String
    let id: Int
}
struct QualificationModel: Codable {
    let qualification: String
    let id: Int
}
struct SpeciltyModel: Codable {
    let department: String
    let id: Int
}
struct DropDownResource {
    
    func getQualificationData(completion : @escaping (_ result: ResponseResult<[QualificationModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getQualification
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [QualificationModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getProfessionalData(completion : @escaping (_ result: ResponseResult<[ProfessionModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getProfession
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [ProfessionModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    
    func getSpecilityData(completion : @escaping (_ result: ResponseResult<[SpeciltyModel]>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getSpeacilty
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: [SpeciltyModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
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
