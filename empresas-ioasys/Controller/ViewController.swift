//
//  ViewController.swift
//  empresas-ioasys
//
//  Created by Mateus Fernandes on 01/09/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //MARK - IBoutlet from Storyboard
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    var userController = UserController()
    var headersApi: Dictionary<String, Any> = [:]
    
    
    //MARK - Local Variables and Constants
    var userNameLogin: String = ""
    var userPasswordLogin: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func loginButton(_ sender: Any) {
        userNameLogin = textEmail.text!
        userPasswordLogin = textPassword.text!
        
        let user = userController.getUserToAuthenticate(email: self.userNameLogin, password: self.userPasswordLogin)
        
        let contentApi = self.userController.authenticateUser(user: user) as! Dictionary<String, Any>
       
        if contentApi["error"] == nil {
            self.headersApi = contentApi
            performSegue(withIdentifier: "HomeView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeView" {
            let viewDestination = segue.destination as! HomeViewController
            viewDestination.headers = self.headersApi
        }
    }
}

