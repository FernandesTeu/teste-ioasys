//
//  UserController.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 02/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import Foundation

class UserController {
    
    
    func getUserToAuthenticate(email: String, password: String) -> User {
        return User(email: email, password: password)
    }
    
    func authenticateUser(user: User) -> Any {
        var responseForApi: Dictionary<String, Any> = [ : ]
        let signInUser = UserApi.init(endPoint: "users/auth/sign_in")
        let semaphore = DispatchSemaphore(value: 0)
        signInUser.signIn(user: user, completion: { result in
            switch result {
                case .success(let headers):
                    responseForApi = headers
                case .failure(let error):
                    responseForApi = ["error": error]
            }
            semaphore.signal()
        })
        _ = semaphore.wait(timeout: .distantFuture)
       
        return responseForApi
    }
}
