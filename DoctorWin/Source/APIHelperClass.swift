//
//  APIHelperClass.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/02/22.
//

import Foundation

struct APIHelperClass {
    func callWebserviceToMakeRequest<T:Decodable>(requestUrl: URL, requestBody: Data?, resultType: T.Type, httpMethod:HTTPMethod,  completionHandler:@escaping(_ result: T)-> Void) {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        if httpMethod != .get {
            urlRequest.httpBody = requestBody!
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        } else {
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept-type")
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if(data != nil && data?.count != 0)  {
                do {
                    let decodedApps = try JSONDecoder().decode(T.self, from: data!)
                    
                    completionHandler(decodedApps)
                    print(decodedApps)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
            else if (error as? URLError)?.code == .timedOut {
                // Handle session timeout
            }
        }.resume()
    }
}
