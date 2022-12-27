//
//  ShopViewModel.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation
protocol ShopWishlistDelegate {
    func didReciveBookmarkShopData(response: ShopResponseModel?, error: String?)
    func didReciveUploadShopData(response: ShopResponseModel?, error: String?)
    func didReciveRecentShopData(response: ShopResponseModel?, error: String?)
}

protocol ShopDelegate {
    func didReciveShopData(response: ShopResponseModel?, error: String?)
    func didReciveShopCategoryData(response: [ShopCategoryModel]?, error: String?)
    func didReciveShopBannerData(response: [ImageBannerModel]?, error: String?)
}

struct ShopViewModel {
    var delegate : ShopDelegate?
    var delegate1: ShopWishlistDelegate?
 
    func getShopData(userID: String, category: String) {
        let homeResource = ShopResource()
        homeResource.getshopData(userID: userID, category: category) { response in
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
    func getShopBannerData(userID: String) {
        let homeResource = ShopResource()
        homeResource.getshopBannerData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReciveShopBannerData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReciveShopBannerData(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getShopWishlistData(userID: String) {
        let homeResource = ShopResource()
        homeResource.getshopData(userID: userID, index: 2) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate1?.didReciveBookmarkShopData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate1?.didReciveBookmarkShopData(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getShopUploadData(userID: String) {
        let homeResource = ShopResource()
        homeResource.getshopData(userID: userID, index: 0) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate1?.didReciveUploadShopData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate1?.didReciveUploadShopData(response: nil, error: error)
                }
            
            }
            
        }
    }
    func getShopRecentData(userID: String) {
        let homeResource = ShopResource()
        homeResource.getshopData(userID: userID, index: 1) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate1?.didReciveRecentShopData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate1?.didReciveRecentShopData(response: nil, error: error)
                }
            
            }
            
        }
    }
}

