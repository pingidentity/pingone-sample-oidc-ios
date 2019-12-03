//
//  AppDelegate.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/26/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        if let code = url["code"] {
            AuthConfigUtil.shared.accessCode = code
            // open main view controoler to go with login flow
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
            mainVC.modalPresentationStyle = .fullScreen
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = mainVC
            self.window?.makeKeyAndVisible()
            
            return true
        } else {
            return false
        }
    }
}
