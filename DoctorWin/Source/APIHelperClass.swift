//
//  APIHelperClass.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/02/22.
//

import Foundation

struct APIHelperClass {
    func callWebserviceToMakeRequest<T:Decodable>(requestUrl: URL, requestBody: Data?, resultType: T.Type, httpMethod:HTTPMethod,  completionHandler:@escaping(Result<T, RequestError>)-> Void) {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        if httpMethod != .get {
            urlRequest.httpBody = requestBody!
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        } else {
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept-type")
        if User.shared.token != "" {
            urlRequest.setValue("\(User.shared.token)", forHTTPHeaderField: "jwt")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if(data != nil && data?.count != 0)  {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data!)
                    completionHandler(.success(result))
                }
                catch let error {
                    print(error)
                    completionHandler(.failure(RequestError.decodingError))
                }
            } else if (data != nil && data?.count != 0) {
                completionHandler(.failure(.internalServerError))
            }
            else if (error as? URLError)?.code == .timedOut {
                completionHandler(.failure(.internalServerError))
            }
        }.resume()
    }
}
