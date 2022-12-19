//
//  BookMarkViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/06/2565 BE.
//

import Foundation

protocol JobsBookMarkDelegate {
    func didReceiveBookmakedJobs(response: [JobModel]?, error: String?)
}

protocol SocailBookMarkDelegate {
    func didReceiveBookmakedSocail(response: HomeResponseModel?, error: String?)
}

protocol BookMarkDelegate: JobBookmarkedDelegate  & SocailBookMarkDelegate  {
    
}
struct BookMarkViewModel {
    var delegate : BookMarkDelegate?
    
    func getBookMarkedJobs(userID: String) {
        let resource = CustomJobResource()
        resource.getBookmarkedJobData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedJobs(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveBookmakedJobs(response: nil, error: error)
                }
            }
        }
    }
    
   
    func getBookmarkSocail(display_status: Int, page: Int) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getBookMarks + "?display_status=\(display_status)&page=\(page)"
        
        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedSocail(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReceiveBookmakedSocail(response: nil, error: error)
                }
                
            }
        }
 
    }
    
   
}
