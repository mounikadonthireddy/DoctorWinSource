//
//  ShopResource.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation
struct ShopResource {
    
    func getshopData(userID: String, category: String, completion : @escaping (_ result: ResponseResult<ShopResponseModel>) -> Void) {
        var homeUrlStr = ""
        if category != "" {
           homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData +  "?category_name=\(category)"
        } else {
         homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData
        }
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ShopResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    func getshopData(userID: String, index: Int, completion : @escaping (_ result: ResponseResult<ShopResponseModel>) -> Void) {
        var homeUrlStr = ""
        if index == 0 {
           homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopSale + "?method=view"
        } else if index == 1 {
         homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopSale + "?method=Viewed"
        } else if index == 2 {
            homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopSale + "?method=Bookmark"
           }
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ShopResponseModel.self) { result in
                
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
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopCategory + ApiEndpoints.userID + "=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ShopCategoryResponseModel.self) { result in
                
                switch result {
                case .success(let data):
                    if data.is_active {
                        completion(.success(data.shopResponse ?? []))
                    }
                    else {
                        completion(.failure("Please try Again After SomeTime"))
                    }
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    func getshopBannerData(userID: String, completion : @escaping (_ result: ResponseResult<[ImageBannerModel]>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopBanner
        let urlString = homeUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [ImageBannerModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( _):
                    completion(.failure("Please try Again After SomeTime"))
                    
                }
            }
        }
        
    }
    func getshopCategoryData(userID: String, productId: Int, completion : @escaping (_ result: ResponseResult<ShopDetailsModel>) -> Void) {
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopData + "?productid=\(productId)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: ShopDetailsModel.self) { result in
                
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
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.shopBookmark + ApiEndpoints.userID + "=\(request.user_id)&productid=\(request.productid)"
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
