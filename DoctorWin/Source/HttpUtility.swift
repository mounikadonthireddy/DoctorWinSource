//
//  HttpUtility.swift
//  MvvmDemoApp
//
//  Created by Codecat15 on 3/14/2020.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum RequestError: String,Error {
    case invalidUrl = "Please Try again After sometime"
    case internalServerError = "Currently Our Server is down. Please Try again After sometime"
    case decodingError = "Currently we are facing some issue.Please Try again After sometime"
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
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        if User.shared.token != "" {
            urlRequest.setValue("\(User.shared.token)", forHTTPHeaderField: "jwt")
        }
        
        //send Request
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            if error != nil {
                completion(.failure(RequestError.invalidUrl))
            }
            
            if(error == nil && responseData != nil && responseData?.count != 0) {
                print(responseData?.prettyPrintedJSONString ?? "")
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completion(.success(result))
                }
                catch let error {
                    print(error)
                    completion(.failure(RequestError.decodingError))
                }
            } else if (responseData != nil && responseData?.count != 0) {
                completion(.failure(.internalServerError))
            }
            else if (error as? URLError)?.code == .timedOut {
                completion(.failure(.internalServerError))
            }
            
        }.resume()
    }
    
    func putMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T, RequestError>)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.put, completionHandler: completionHandler)
        
    }
    func patchMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T, RequestError>)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.patch, completionHandler: completionHandler)
        
    }
    func deleteMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T, RequestError>)-> Void) {
        
        APIHelperClass().callWebserviceToMakeRequest(requestUrl: requestUrl, requestBody: requestBody, resultType: resultType, httpMethod: HTTPMethod.delete, completionHandler: completionHandler)
        
    }
    func postMethod<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T, RequestError>)-> Void) {
        
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
        request.httpMethod="POST"
        
        if User.shared.token != "" {
            request.setValue("\(User.shared.token)", forHTTPHeaderField: "jwt")
        }
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
struct ImageUploadModel {
    let fileName: String
    let imageName: String
    let image: UIImage
}
struct AGImageStructInfo {
    var fileName: String
    var type: String
    var data: Data
}

class AGUploadImageWebServices {
    
    private let boundary = "Boundary-\(NSUUID().uuidString)"
    private var request: URLRequest?
    
    init(url: String, parameter param : [String: Any], inputData:[String:Any], method:HTTPMethod) {
        guard let url = URL(string: url) else { return }
        
        request = URLRequest(url: url)
        if User.shared.token != "" {
            request?.setValue("\(User.shared.token)", forHTTPHeaderField: "jwt")
        }
        request?.httpMethod = method.rawValue
        request?.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request?.httpBody = createBody(with: param, input: inputData, boundary: boundary)
    }
    
    func responseJSON(completionHandler: @escaping ([String: Any]?, Error?) -> ()) {
        guard let request = request else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                debugPrint("System error:- \(String(describing: error))")
                completionHandler(nil, error)
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async {
                do {
                    let dicResponse = try JSONSerialization.jsonObject(with: data, options: []) as?  [String: Any]
                    print("Response Dict:- \(String(describing: dicResponse))")
                    completionHandler(dicResponse, nil)
                } catch {
                    completionHandler(nil, error)
                    print("Response Error:- \(String(describing: error))")
                }
            }
        }
        
        task.resume()
    }

    internal func createBody(with parameters: [String: Any],input:[String:Any]?, boundary: String) -> Data {
        var body = Data()
        if input != nil {
            for (key, value) in input! {
                body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }

        for (key, value) in parameters {
            if let imageInfo = value as? AGImageStructInfo {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imageInfo.fileName)\"\r\n")
                body.append("Content-Type: \(imageInfo.type)\r\n\r\n")
                body.append(imageInfo.data)
                body.append("\r\n")
            }
            else if let imageInfo = value as? [AGImageStructInfo] {
                for image in imageInfo {
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(image.fileName)\"\r\n")
                    body.append("Content-Type: \(image.type)\r\n\r\n")
                    body.append(image.data)
                    body.append("\r\n")
                }
            }
            else{
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
}

extension UIImage {
    func toData() -> Data{
        return self.jpegData(compressionQuality: 0.1)! as Data
    }
}

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
