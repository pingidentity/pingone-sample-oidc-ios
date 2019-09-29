//
//  ViewController.swift
//  PingOne
//
//  Created by Vadym Kovalskyi on 9/25/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit

class LaunchViewController: DefaultViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load initial data from bundle and auth configuration
        let authUtil = AuthConfigUtil.shared
        try! authUtil.setUP { isLoaded in
            if (authUtil.authData != nil && authUtil.configData != nil) {
                if (!authUtil.isUserAuthorized()) {
                    self.openLoginView()
                } else {
                    self.openMainView()
                }
            }
        }
    }
}
