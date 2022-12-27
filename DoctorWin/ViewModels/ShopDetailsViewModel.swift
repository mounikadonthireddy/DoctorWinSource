//
//  ShopDetailsViewModel.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation

protocol ProductDetailsDelegate {
    func didReciveProductData(response: ShopDetailsModel?, error: String?)
   
}


struct ShopDetailsViewModel {
    var delegate : ProductDetailsDelegate?
 
    func getShopData(userID: String, productId: Int) {
        let homeResource = ShopResource()
        homeResource.getshopCategoryData(userID: userID, productId: productId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveProductData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveProductData(response: nil, error: error)
                }
            
            }
            
        }
    }
}
