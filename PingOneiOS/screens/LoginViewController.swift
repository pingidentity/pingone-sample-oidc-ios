//
//  LoginViewController.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/26/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginClick(sender: UIButton){
        // open webview with auth
        UIApplication.shared.open(buildLoginUrl())
    }
    
    private func buildLoginUrl() -> URL {
        let configData = AuthConfigUtil.shared.configData!
        let authData = AuthConfigUtil.shared.authData
        
        let url = URL(string: authData!.authorization_endpoint)!
        let queryItems = [
            URLQueryItem(name: "redirect_uri", value: configData.redirect_uri),
            URLQueryItem(name: "client_id", value: configData.client_id),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "nonce", value: UUID().uuidString),
            URLQueryItem(name: "prompt", value: "login")
        ]
        
        return url.appending(queryItems: queryItems)!
    }
}
