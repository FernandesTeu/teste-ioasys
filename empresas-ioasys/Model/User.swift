//
//  User.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 02/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }   
}

struct UserDataHeader {
    var uid: String?
    var accessToken: String?
    var client: String?
    var statusCode: Int?
    var headerData: HeadersUserApi
    
    func getUid() -> String {
        return uid!
    }
    
    func getaAccessToken() -> String {
        return accessToken!
    }
    
    func getClient() -> String {
        return client!
    }
    
    func getStatusCode() -> Int {
        return statusCode!
    }
}

struct HeadersUserApi {
    var uid: String
    var client: String
    var token: String
    
    init(uid: String, client: String, token: String) {
        self.client = client
        self.uid = uid
        self.token = token
    }
}
