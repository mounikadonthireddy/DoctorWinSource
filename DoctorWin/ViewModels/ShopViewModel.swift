//
//  ShopViewModel.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation

protocol ShopDelegate {
    func didReciveShopData(response: [ShopModel]?, error: String?)
    func didReciveShopCategoryData(response: [ShopCategoryModel]?, error: String?)
}

struct ShopViewModel {
    var delegate : ShopDelegate?
 
    func getShopData(userID: String, pageNum: Int) {
        let homeResource = ShopResource()
        homeResource.getshopData(userID: userID, pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveShopData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveShopData(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getShopCategoryData(userID: String, pageNum: Int) {
        let homeResource = ShopResource()
        homeResource.getshopCategoryData(userID: userID, pageNum: pageNum) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveShopCategoryData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveShopCategoryData(response: nil, error: error)
                }
            
            }
            
        }
    }
}
