//
//  MentorViewModel.swift
//  DoctorWin
//
//  Created by AHP on 21/03/2566 BE.
//

import Foundation
protocol MentorViewModelDelegate {
    func didReciveTestimonalsData(response: TestimonialResponseModel?, error: String?)
    func didReciveDailyUpdatesData(response: DailyUpdatesResponseModel?, error: String?)
}

struct MentorViewModel {
    var delegate : MentorViewModelDelegate?
    
    func getTestimonalsDataFromAPI(pageNum: Int) {
        let homeResource = MentorResource()
        homeResource.getTestimonalsData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveTestimonalsData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveTestimonalsData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getDailyUpdatesDataFromAPI(pageNum: Int) {
        let homeResource = MentorResource()
        homeResource.getDailyUpdatesData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveDailyUpdatesData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveDailyUpdatesData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
