//
//  BookMarkViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/06/2565 BE.
//

import Foundation

protocol JobsBookMarkDelegate {
    func didReceiveBookmakedJobs(response: [CarrierModel]?, error: String?)
}
protocol CasesBookMarkDelegate {
    func didReceiveBookmakedCases(response: [CasesDataModel]?, error: String?)
}
protocol NewsBookMarkDelegate {
    func didReceiveBookmakedNews(response: [NewsModel]?, error: String?)
}
protocol SocailBookMarkDelegate {
    func didReceiveBookmakedSocail(response: [HomeDataModel]?, error: String?)
}
protocol ClassiFieldBookmarkDelegate {
    func didReceiveBookmakedClassicfield(response: [CarrierModel]?, error: String?)
}
protocol AnswersBookmarkDelegate {
    func didReceiveBookmakedAnswers(response: [AnswersModel]?, error: String?)
}
protocol BookMarkDelegate: JobBookmarkedDelegate & CasesBookMarkDelegate & NewsBookMarkDelegate & SocailBookMarkDelegate & AnswersBookmarkDelegate {
    
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
    func getBookMarkedJAnswers(userID: String) {
        let resource = CustomJobResource()
        resource.getBookmarkedAnswers(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedAnswers(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveBookmakedAnswers(response: nil, error: error)
                }
            }
        }
    }
    func getBookmarkNews(userID: String) {
        let homeResource = NewsJobResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkNews + ApiEndpoints.userID + "=\(userID)"
          homeResource.getMyNewsData1(urlString: homeUrlStr) { response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let data):
                        self.delegate?.didReceiveBookmakedNews(response: data, error: nil)
                        
                    case .failure(let error):
                        self.delegate?.didReceiveBookmakedNews(response: nil, error: error)
                    }
                    
                }
            }
        }
    func getBookmarkSocail(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkSocail + ApiEndpoints.userID + "=\(userID)&page=1"

        homeResource.getBookmarkSocail(urlString: homeUrlStr) { response in
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
    
    func getBookmarkCases(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkComplaint + ApiEndpoints.userID + "=\(userID)&page=1"

        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedCases(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReceiveBookmakedCases(response: nil, error: error)
                }
                
            }
        }
    }
    func getBookmarkAnswers(userID: String) {
        let homeResource = HomeResource()
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.bookmarkComplaint + ApiEndpoints.userID + "=\(userID)&page=1"

        homeResource.getBookmarkCases(urlString: homeUrlStr) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveBookmakedCases(response: data, error: nil)

                case .failure(let error):
                    self.delegate?.didReceiveBookmakedCases(response: nil, error: error)
                }
                
            }
        }
    }
}
