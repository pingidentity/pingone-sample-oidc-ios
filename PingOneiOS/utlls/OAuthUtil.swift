//
//  OAuthUtil.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/29/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import Alamofire

class OAuthUtil {

    private let authUtil = AuthConfigUtil.shared
    static let shared = OAuthUtil()
    
    private init() {}
    
    func proceedWithPost(completion: @escaping (Bool) -> Void) {
        let url = String(format: authUtil.authData!.token_endpoint)
        
        let parameters = [
            "code": authUtil.accessCode,
            "grant_type": "authorization_code",
            "client_id": authUtil.configData?.client_id,
            "client_secret": authUtil.configData?.client_secret,
            "redirect_uri": authUtil.configData?.redirect_uri
        ]
        
        AF.request(url, method: .post, parameters: parameters)
            .responseDecodable { (response: DataResponse<AccessCode, AFError>) in
                guard (response.error == nil) else {
                    print("Error while gathering access code: \(String(describing: response.error))")
                    completion(false)
                    return
                }
                
                let decoder = JSONDecoder()
                let accessCode  = try? decoder.decode(AccessCode.self, from: response.data!)
                self.authUtil.saveAccessCode(accessToken: accessCode!)
                completion(true)
        }
    }
    
    func proceedWithBasic(completion: @escaping (Bool) -> Void) {
        let url = String(format: authUtil.authData!.token_endpoint)
        let credentials = authUtil.configData!.client_id + ":" + authUtil.configData!.client_secret
        let basic = "Basic " + credentials.toBase64()!
        
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        headers.add(name: "Authorization", value: basic)
        
        let parameters = [
            "code": authUtil.accessCode,
            "grant_type": "authorization_code",
            "redirect_uri": authUtil.configData?.redirect_uri
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable { (response: DataResponse<AccessCode, AFError>) in
                print(response)
                guard (response.error == nil) else {
                    print("Error while gathering access code: \(String(describing: response.error))")
                    completion(false)
                    return
                }

                let decoder = JSONDecoder()
                let accessCode  = try? decoder.decode(AccessCode.self, from: response.data!)
                self.authUtil.saveAccessCode(accessToken: accessCode!)
                completion(true)
        }
    }
    
    func proceedWithNone(completion: @escaping (Bool) -> Void) {
        let url = String(format: authUtil.authData!.token_endpoint)

        let parameters = [
            "code": authUtil.accessCode,
            "grant_type": "authorization_code",
            "client_id": authUtil.configData?.client_id,
            "redirect_uri": authUtil.configData?.redirect_uri
        ]

        AF.request(url, method: .post, parameters: parameters)
            .responseDecodable { (response: DataResponse<AccessCode, AFError>) in
                guard (response.error == nil) else {
                    print("Error while gathering access code: \(String(describing: response.error))")
                    completion(false)
                    return
                }

                let decoder = JSONDecoder()
                let accessCode = try? decoder.decode(AccessCode.self, from: response.data!)
                self.authUtil.saveAccessCode(accessToken: accessCode!)
                completion(true)
        }
    }
    
    func fetchUserInfo(completion: @escaping (UserInfo?, AFError?) -> Void) {
        let url = authUtil.authData?.userinfo_endpoint
        let accessCode = authUtil.getAccessCode()
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: accessCode!.token_type + " " + accessCode!.access_token)
        
        AF.request(url!, method: .get, headers: headers)
            .responseDecodable { (response: DataResponse<UserInfo, AFError>) in
                guard (response.error == nil) else {
                    print("Error while gathering access code: \(String(describing: response.error))")
                    self.logout()
                    completion(nil, response.error)
                    return
                }

                let decoder = JSONDecoder()
                let userInfo = try? decoder.decode(UserInfo.self, from: response.data!)
                completion(userInfo, nil)
        }
    }
    
    func logout() {
        authUtil.deleteAccessCode()
    }

}

