//
//  ShopResource.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation
struct ShopResource {
    
    func getshopData(userID: String, category: String, completion : @escaping (_ result: ResponseResult<[ShopModel]>) -> Void) {
        var homeUrlStr = ""
        if category != "" {
           homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData + "?category_name=\(category)"
        } else {
         homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData + "?user_id=\(userID)"
        }
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
    func getshopData(userID: String, index: Int, completion : @escaping (_ result: ResponseResult<[ShopModel]>) -> Void) {
        var homeUrlStr = ""
        if index == 0 {
           homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopSale + "?user_id=\(userID)"
        } else if index == 1 {
         homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopRecent + "?user_id=\(userID)"
        } else if index == 2 {
            homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopBookmark + "?user_id=\(userID)"
           }
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
    func saveProduct(request: ShopSaveRequest, completion : @escaping  (_ result: ResponseResult<StatusResponseModel>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopBookmark + "?user_id=\(request.user_id)&productid=\(request.productid)"
        let homeUrl = URL(string: homeUrlStr)!
        
        let helper = APIHelperClass()
        do {
            let postBody = try JSONEncoder().encode(request)
            
            helper.callWebserviceToMakeRequest(requestUrl: homeUrl, requestBody: postBody, resultType: StatusResponseModel.self, httpMethod: HTTPMethod.post) {
                result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
                
            }
            
        } catch let error {
            debugPrint(error)
        }
    }
}
