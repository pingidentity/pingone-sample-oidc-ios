//
//  PKCEData.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 11/28/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//

struct PKCEData: Encodable {
    let name: String
    let description: String
    let pkceEnforcement: String
    let enabled: Bool
    let type: String
    let `protocol`: String
    let responseTypes, grantTypes: [String]
    let tokenEndpointAuthMethod: String
    let postLogoutRedirectUris, redirectUris: [String]
    
    var asDictionary : [String:Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
        guard label != nil else { return nil }
        return (label!,value)
      }).compactMap{ $0 })
      return dict
    }
}
