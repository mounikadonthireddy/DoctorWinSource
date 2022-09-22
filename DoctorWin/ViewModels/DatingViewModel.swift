//
//  DatingViewModel.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import Foundation


protocol DatingViewModelDelegate {
    func didReciveDatingData(response: [MatchesModel]?, error: String?)
}

struct DatingViewModel {
    var delegate : DatingViewModelDelegate?
 
    func getDatingProfilesData(userID: String) {
        let homeResource = DatingResource()
        homeResource.getDatingData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveDatingData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveDatingData(response: nil, error: error)
                }
            
            }
            
        }
    }
}
