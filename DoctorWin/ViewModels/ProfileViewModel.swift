//
//  ProfileViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 04/12/21.
//

import Foundation
protocol ProfileEditViewModelDelegate {
    func didReceiveTopJobs(response: ProfileEditDropDownModel?, error: String?)
    func didProfessionalData(response: ProfessionalDropDownModel?, error: String?)

}

struct ProfileEditViewModel {
    var delegate : ProfileEditViewModelDelegate?
    func getLanguageAndGenderDropDownData(userID: String) {
        let resource = ProfileEditResource()
        resource.getProfileEditDropDownData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveTopJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveTopJobs(response: nil, error: error)
                }
               
            }
        }
    }
    func getProfessionalDropDownData(userID: String) {
        let resource = ProfileEditResource()
        resource.getProfessionalEditDropDownData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didProfessionalData(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didProfessionalData(response: nil, error: error)
                }
                
            }
        }
    }

    
}
struct ProfileViewModel {
    var delegate : ProfileViewModelDelegate?

    func getProfileData(userID: String) {
        let resource = ProfileEditResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getProfileDetails + ApiEndpoints.userID + "=\(userID)&display_status=7"

        resource.getProfileData(url: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveProfileData(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReciveProfileData(response: nil, error: error)
                }
                
            }
        }
    }
   
    func getProfileExperienceData(userID: String) {
        let resource = ProfileEditResource()
        resource.getProfileExperienceData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveProfileExperienceData(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReciveProfileExperienceData(response: nil, error: error)
                }
                
            }
        }
    }
    
    func deleteExp(userID: String, expID: Int,request: DeleteExpModel,completion : @escaping (_ result: ProfessionalResponseModel?) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.addExperience + ApiEndpoints.userID + "=\(userID)&exp_id=\(expID)"
        let homeUrl = URL(string: homeUrlStr)!
        let httpUtility = HttpUtility()
        do {
            let postBody = try JSONEncoder().encode(request)

            httpUtility.deleteMethod(requestUrl: homeUrl, requestBody: postBody, resultType: ProfessionalResponseModel.self) {
                response in
                switch response {
                case .success(let data):
                    completion(data)
                    
                case .failure( _):
                    completion(nil)
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
    

}
protocol ProfileViewModelDelegate {
 
    func didReciveProfileData(response: ProfileModel?, error: String?)
    func didReciveProfileExperienceData(response: [ExperienceModel]?, error: String?)

}
