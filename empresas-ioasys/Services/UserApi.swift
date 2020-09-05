//
//  UserApi.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 02/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case responseError
    case decodingError
    case encoldingProblem
}

struct HeadersApiUser {
    var uid: String
    var client: String
    var accessToken: String
    
    init(uid: String, client: String, accessToken: String) {
        self.accessToken = accessToken
        self.uid = uid
        self.client = client
    }
    
}
struct UserApi {
        
    let resourceURL: URL
    
    init(endPoint: String) {
        let apiUrl = "https://empresas.ioasys.com.br/api/v1/\(endPoint)"
        guard let resourceURL = URL(string: apiUrl) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func signIn(user: User, completion: @escaping(Result<Dictionary<String, Any>,ApiError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody =  try JSONEncoder().encode(user)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, _) in
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(.responseError))
                    return
                }
                
                let dataResponse = [
                    "uid": httpResponse.allHeaderFields["uid"] as! String,
                    "accessToken" : httpResponse.allHeaderFields["access-token"] as! String,
                    "client": httpResponse.allHeaderFields["client"] as! String,
                    "statusCode": httpResponse.statusCode
                    ] as [String : Any]
                
                completion(.success(dataResponse))
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encoldingProblem))
        }
    }
    
    
}

