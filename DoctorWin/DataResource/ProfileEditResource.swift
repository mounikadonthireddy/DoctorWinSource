//
//  ProfileEditResource.swift
//  DoctorWin
//
//  Created by N517325 on 03/12/21.
//

import Foundation
struct ProfileEditResource {
    func editProfilePersonalInfoData(userID: String,profileReq: PersonalInfoEditModel1,  completion : @escaping (_ result: ProfileUpdateResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.personalEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfileUpdateResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func getProfileData(userID: String, completion : @escaping (_ result: ResponseResult<ProfileDataModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ProfileDataModel.self) { result in
                
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
    func getProfileExperienceData(userID: String, completion : @escaping (_ result: ResponseResult<[ExperienceModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ExperienceModel].self) { result in
                
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
    
    func editProfileProfessionalInfoData(userID: String,profileReq: ProfessionalEditModel,  completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.professionalEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func editProfileAboutMe(userID: String,profileReq: EditAboutModel,  completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func registerProfileAboutMe(userID: String,profileReq: EditAboutModel,  completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func registerProfileSkill(userID: String,profileReq: EditSkillModel,  completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.patchMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func editProfileSkill(userID: String,profileReq: EditSkillModel,  completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.profileEdit + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func addExperience(userID: String,profileReq: AddExperienceModel,  completion: @escaping(Result<ResponseModel, RequestError>)-> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + "?user_id=\(userID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)
            httpUtility.postMethod(urlString: homeUrlStr, requestBody: postBody, resultType: ResponseModel.self) {
                response in
                _ = completion(response)
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    func getProfileEditDropDownData(userID: String, completion : @escaping (_ result: ResponseResult<ProfileEditDropDownModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.personalEdit + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: ProfileEditDropDownModel.self) { result in
                
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
    func getProfessionalEditDropDownData(userID: String, completion : @escaping (_ result: ResponseResult<ProfessionalDropDownModel>) -> Void) {
        let profileUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.professionalData + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: profileUrlStr, resultType: ProfessionalDropDownModel.self) { result in
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
    func editExperince(userID: String, expId:Int,profileReq: AddExperienceModel,  completion : @escaping (_ result: ExperienceModel?) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + "?user_id=\(userID)&exp_id=\(expId)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(profileReq)

            httpUtility.putMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ExperienceModel.self) {
                response in
                _ = completion(response)
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
