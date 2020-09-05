//
//  CompaniesApi.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 04/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import Foundation

class CompaniesApi {
     private static let apiPathUrl:String = "https://empresas.ioasys.com.br/api/v1/enterprises/1"
    //private static let apiPathUrl:String = "https://empresas.ioasys.com.br/api/v1/enterprises?enterprise_types=1&"
    
    
    class func filterEnterpriseCompanies(userHeaders: Dictionary<String, Any>, onComplete: @escaping ([Companies]) -> Void, onError: @escaping (String) -> Void ) {
        
        //let urlString = "\(self.apiPathUrl)name=\(textSearched)"
       
        guard let url = URL(string: apiPathUrl) else { return }
        print(url)
        let client = userHeaders["client"] as! String
        let accessToken = userHeaders["accessToken"] as! String
        let uid = userHeaders["uid"] as! String
        
        let config = URLSessionConfiguration.default
        let headersHttp = ["Content-Type":"application/json", "client": "\(client)", "access-token": "Bearer \(accessToken)", "uid": "\(uid)"]
        print(headersHttp)
        config.httpAdditionalHeaders = headersHttp
        
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError("deuRuim no response")
                    return
                }
                print(response)
                if response.statusCode == 200 {
                    guard let data = data else {
                        onError("deuTreta no data")
                        return }
                    
                    do {
                        let enterprises = try JSONDecoder().decode([Companies].self, from: data)
                        onComplete(enterprises)
                    } catch {
                        onError("deu ruim no Json")
                    }
                }
                
            } else {
                onError("deu treta\(String(describing: error))")
            }
            
        }
        task.resume()
    }
}
