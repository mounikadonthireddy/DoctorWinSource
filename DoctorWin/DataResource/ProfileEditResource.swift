//
//  ProfileEditResource.swift
//  DoctorWin
//
//  Created by N517325 on 03/12/21.
//

import Foundation
struct ProfileEditResource {
    func editProfilePersonalInfoData(userID: String,profileReq: PersonalInfoEditModel1,  completion : @escaping (_ result: ResponseResult<ProfileUpdateResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.personalEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfileUpdateResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func editSelfdataPersonalInfoData(userID: String,profileReq: SelfDataEditModel,  completion : @escaping (_ result: ResponseResult<StatusResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.personalEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func getProfileData(url: String, completion : @escaping (_ result: ResponseResult<ProfileModel>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: url, resultType: UserProfileModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                        completion(.success(data.userDetails!))
                    } else {
                        completion(.failure(""))
                    }
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getGroupProfileData(url: String, completion : @escaping (_ result: ResponseResult<GroupProfileModel>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: url, resultType: GroupProfileDataModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active == true {
                        completion(.success(data.userDetails!))
                    } else {
                        completion(.failure(""))
                    }
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getProfileExperienceData(userID: String, completion : @escaping (_ result: ResponseResult<[ExperienceModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ExperienceModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    
    func editProfileProfessionalInfoData(userID: String,profileReq: ProfessionalEditModel,  completion : @escaping (_ result: ResponseResult<ProfessionalResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.professionalEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func editProfileAboutMe(userID: String,profileReq: EditAboutModel,  completion : @escaping (_ result: ResponseResult<ProfessionalResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func registerProfileAboutMe(userID: String,profileReq: EditAboutModel,  completion : @escaping (_ result: ResponseResult<ProfessionalResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func registerProfileSkill(userID: String,profileReq: EditSkillModel,  completion : @escaping (_ result: ResponseResult<ProfessionalResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func editProfileSkill(userID: String,profileReq: EditSkillModel,  completion : @escaping (_ result: ResponseResult<ProfessionalResponseModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + ApiEndpoints.userID + "\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func addExperience(userID: String,profileReq: AddExperienceModel,  completion: @escaping(ResponseResult<ResponseModel>)-> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + ApiEndpoints.userID + "=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func getProfileEditDropDownData(userID: String, completion : @escaping (_ result: ResponseResult<ProfileEditDropDownModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.personalEdit + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: ProfileEditDropDownModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getProfessionalEditDropDownData(userID: String, completion : @escaping (_ result: ResponseResult<ProfessionalDropDownModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.professionalData + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: ProfessionalDropDownModel.self) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func editExperince(userID: String, expId:Int,profileReq: AddExperienceModel,  completion : @escaping (_ result: ResponseResult<ExperienceModel?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + ApiEndpoints.userID + "=\(userID)&exp_id=\(expId)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            
            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ExperienceModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func followPerson(request: FollowRequest, completion : @escaping  (_ result: ResponseResult<Bool?>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.complaintFollow + ApiEndpoints.userID + "=\(request.dworks_id)&follow_id=\(request.follow_id)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            httpUtility.postMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ComplaintFollowResponse.self) {
                result in
                
                switch result {
                case .success(let data):
                    completion(.success(data.follow))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                    
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
}

struct ProfileEditDropDownModel: Codable {
    let gender: [String]
    let language: [String]
}

struct ProfessionalDropDownModel: Codable {
    let ug_course: [String]
    let pg_course: [String]
    let department: [String]
    let ug_institute: [String]
    let pg_institute: [String]
}
