//
//  ShopResource.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation
struct ShopResource {
    
    func getshopData(userID: String, pageNum: Int, completion : @escaping (_ result: ResponseResult<[ShopModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ShopModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    func getshopCategoryData(userID: String, pageNum: Int, completion : @escaping (_ result: ResponseResult<[ShopCategoryModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopCategory + "?user_id=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [ShopCategoryModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    func getshopCategoryData(userID: String, productId: Int, completion : @escaping (_ result: ResponseResult<ProductDetailsModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData + "?user_id=\(userID)&productid=\(productId)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ProductDetailsModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
}
