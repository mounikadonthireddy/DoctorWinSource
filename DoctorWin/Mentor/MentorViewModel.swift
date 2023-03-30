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
    func didReciveFAQData(response: FAQResponseModel?, error: String?)
    func didMentorPlanData(response: MentorPlanResponseModel?, error: String?)

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
    func getFAQDataFromAPI(pageNum: Int) {
        let homeResource = MentorResource()
        homeResource.getFAQData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveFAQData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveFAQData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getServicesFromAPI(pageNum: Int) {
        let homeResource = MentorResource()
        homeResource.getServicesData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didMentorPlanData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didMentorPlanData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getAboutAppAPI(pageNum: Int) {
        let homeResource = MentorResource()
        homeResource.getAskMentorData(pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didMentorPlanData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didMentorPlanData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
protocol MentorServicesViewModelDelegate {
    func didReciveServicesData(response: ServicesResponseModel?, error: String?)
}
struct MentorServicesViewModel {
    var delegate : MentorServicesViewModelDelegate?
    
    func getTestimonalsDataFromAPI(id: Int) {
        let homeResource = MentorResource()
        homeResource.getServicesData(id: id) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveServicesData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveServicesData(response: nil, error: error)
                }
                
            }
            
        }
    }
}
