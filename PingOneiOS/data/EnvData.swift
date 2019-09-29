//
//  EnvData.swift
//  PingOne
//
//  Created by Vadym Kovalskyi on 9/25/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
struct EnvData:Decodable {
    let environment_id: String
    let client_id: String
    let redirect_uri: String
    let authorization_scope: String
    let discovery_uri: String
    let token_method: String
    let client_secret: String
}
