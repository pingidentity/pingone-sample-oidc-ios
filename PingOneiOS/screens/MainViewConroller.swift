//
//  MainViewConroller.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/27/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit
import Alamofire
import JWTDecode

class MainViewController: DefaultViewController {
    
    private let authUtil = AuthConfigUtil.shared
    private let ouathUtil = OAuthUtil.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        proceedWithFlow()
    }
    
    @IBAction func infoUserClick(sender: UIButton) {
        ouathUtil.fetchUserInfo { userInfo, error in
            if error == nil {
                self.hideLoading()
                self.openDetails(dictionary: userInfo!.asDictionary)
            }
        }
    }
    
    @IBAction func infoTokenClick(sender: UIButton) {
        let jwt = authUtil.getJWT()
        self.openDetails(dictionary: jwt.asDictionary)
    }
    
    @IBAction func logoutClick(sender: UIButton) {
        ouathUtil.logout()
        openLoginView()
    }

    private func proceedWithFlow() {
        if (authUtil.accessCode != nil) {
            showLoading()
            switch (authUtil.configData?.token_method) {
                case TokenMethod.CLIENT_SECRET_BASIC.description:
                    self.ouathUtil.proceedWithBasic { success in
                        self.proceedAfterLogin(success: success)
                }
                case TokenMethod.CLIENT_SECRET_POST.description:
                    self.ouathUtil.proceedWithPost { success in
                        self.proceedAfterLogin(success: success)
                }
                case TokenMethod.NONE.description:
                    self.ouathUtil.proceedWithNone { success in
                        self.proceedAfterLogin(success: success)
                }
                default:
                    print("Method not allowed")
            }
        }
    }
    
    private func proceedAfterLogin(success: Bool) {
        success ? self.hideLoading() : self.openLoginView()
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
