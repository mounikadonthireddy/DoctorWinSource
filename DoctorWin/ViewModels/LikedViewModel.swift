//
//  SavedViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/06/2565 BE.
//

import Foundation

protocol NewsDelegate {
    func didReceiveNews(response: HomeResponseModel?, error: String?)
}
struct NewsDataViewModel {
    var delegate: NewsDelegate?

    func getNews(userID: String, index: Int) {
        let homeResource = NewsJobResource()
       
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.getNews

        homeResource.getMyNewsData1(urlString: homeUrlStr) { response in
              DispatchQueue.main.async {
                  switch response {
                  case .success(let data):
                      self.delegate?.didReceiveNews(response: data, error: nil)
                      
                  case .failure(let error):
                      self.delegate?.didReceiveNews(response: nil, error: error)
                  }
                  
              }
          }
    }
    
}
