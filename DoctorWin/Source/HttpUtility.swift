//
//  HttpUtility.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/2020.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation
import UIKit
enum RequestError: Error {
    case invalidUrl
    case internalServerError
    case decodingError
    case serverError(error: NSError)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
}


struct HttpUtility {

    func getApiData<T:Decodable>(urlString: String, resultType: T.Type, completion:@escaping(Result<T, RequestError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        //send Request
        URLSession.shared.dataTask(with: url) { (responseData, httpUrlResponse, error) in
            
            if error != nil {
                completion(.failure(.serverError(error: error! as NSError)))
            }
            
            if(error == nil && responseData != nil && responseData?.count != 0) {
                print(responseData?.prettyPrintedJSONString)

                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completion(.success(result))
                }
                catch let error {
                    print(error)
                    completion(.failure(.decodingError))
                }
            } else if (responseData != nil && responseData?.count != 0) {
                completion(.failure(.internalServerError))
            }
            
            
            
        }.resume()
    }
  
    func putMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.put, completionHandler: completionHandler)

    }
    func patchMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.patch, completionHandler: completionHandler)

    }
    func deleteMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.delete, completionHandler: completionHandler)

    }
    func postMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.post, completionHandler: completionHandler)

    }
   
 private   func createBodyWithParameters(parameters: [String: Any]?, imageName: String, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        let body = NSMutableData()
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }

        let multipartStr = String(decoding: body, as: UTF8.self) //to view the multipart form string
        print(multipartStr)
        let filename = imageName
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(imageDataKey)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return body as Data
    }
    
    
  private  func generateBoundaryString() -> String {
        return "----------V2ymHFg03ehbqgZCaKO6jy"
    }
    
    func profileUpload(img: UIImage, url: String, imageName: String, imageUploadName: String, param: [String:Any], completionHandler: @escaping(BoolResponseModel)-> Void ) {
        
        let url = URL(string: url)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod="PATCH"
        
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = img.jpegData(compressionQuality: 0.1)
        
        if imageData==nil {
            print("image data is nil")
            return
        }
        
        request.httpBody = createBodyWithParameters(parameters: param, imageName: imageName, filePathKey: imageUploadName, imageDataKey: imageData!, boundary: boundary)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            //You can print out response object
            print("***** response = \(String(describing: response))")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("**** response data = \(responseString!)")
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(BoolResponseModel.self, from: data!)
                completionHandler(result)
            }
            catch let error {
                print(error)
            }
        }
        task.resume()
        
        
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
