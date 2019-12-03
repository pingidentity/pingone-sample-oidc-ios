//
//  AccessCode.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/27/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
struct AccessCode: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
    let id_token: String
}
