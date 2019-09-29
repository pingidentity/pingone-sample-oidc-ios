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

extension URL {
    subscript(queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
    
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}

