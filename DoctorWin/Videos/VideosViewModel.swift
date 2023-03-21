//
//  VideosViewModel.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import Foundation
protocol VideosViewModelDelegate {
    func didReciveVideosData(response: VideosResponseModel?, error: String?)
}
struct VideosViewModel {
    var delegate : VideosViewModelDelegate?
 
    func getVideosDataFromAPI(pageNum: Int) {
        let homeResource = VideosResource()
        homeResource.getVideosData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveVideosData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveVideosData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
