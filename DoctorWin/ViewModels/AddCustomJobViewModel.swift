//
//  AddCustomJobViewModel.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 28/12/21.
//

import Foundation
protocol AddCustomJobViewModelDelegate {
    func didPostCustomJob(status: Bool, error: String?)
    func didReciveDropdownData(response: CustomJobModel?, error: String?)

}

class AddCustomJobViewModel {
    var delegate: AddCustomJobViewModelDelegate?
    
func postQuestion(request: CreateCustomJobModel, userID: String){
   
    let resource = AddCustomJobResource()
    resource.addCustomJobRequest(request: request, userId: userID) { response in
        
        DispatchQueue.main.async {
            if response.status == "true" {
               self.delegate?.didPostCustomJob(status: true, error: nil)
            } else {
          
               self.delegate?.didPostCustomJob(status: false, error: "error")
           }
       
       }
    }
    
}
    func getDropDownData(userID: String) {
        let resource = AddCustomJobResource()
        resource.getDropDownData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveDropdownData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveDropdownData(response: nil, error: error)
                }
               
            }
        }
    }
   
}
