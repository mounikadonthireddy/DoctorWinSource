//
//  NewsJobResource.swift
//  DoctorWin
//
//  Created by Mounika on 22/12/21.
//

import Foundation
struct NewsJobResource {
    func getNewsData(userID: String, completion : @escaping (_ result: ResponseResult<[NewsDataModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.userNews + "?userid=\(userID)"
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [NewsDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getNewsCategoryData(userID: String,pageId: Int, completion : @escaping (_ result: ResponseResult<[NewscategoryDataModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.newsCategory + "?user_id=\(userID)&page_id=\(pageId)"
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [NewscategoryDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getNewsCategory( completion : @escaping (_ result: ResponseResult<[NewsCategoryModel]>) -> Void) {
        
        let homeUrlStr = ApiEndpoints.baseUrl + ApiEndpoints.newsCategory
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: homeUrlStr, resultType: [NewsCategoryModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getMyNewsData1(urlString: String, completion : @escaping (_ result: ResponseResult<[NewsModel]>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [NewsModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
    func getMyNewsData(urlString: String, completion : @escaping (_ result: ResponseResult<[NewsDataModel]>) -> Void) {
        
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(urlString: urlString, resultType: [NewsDataModel].self) { result in
                
                switch result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure( let error):
                    completion(.failure(error.rawValue))
                }
            }
        }
    }
}
