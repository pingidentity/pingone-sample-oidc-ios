//
//  AuthData.swift
//  PingOne
//
//  Created by Vadym Kovalskyi on 9/25/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
struct AuthData:Decodable {
    let authorization_endpoint: String
    let claim_types_supported: Array<String>
    let claims_parameter_supported: Bool
    let claims_supported: Array<String>
    let end_session_endpoint: String
    let grant_types_supported: Array<String>
    let issuer: String
    let jwks_uri: String
    let request_object_signing_alg_values_supported: Array<String>
    let request_parameter_supported: Bool
    let request_uri_parameter_supported: Bool
    let response_modes_supported: Array<String>
    let response_types_supported: Array<String>
    let scopes_supported: Array<String>
    let subject_types_supported: Array<String>
    let token_endpoint: String
    let token_endpoint_auth_methods_supported: Array<String>
    let userinfo_endpoint: String
    let userinfo_signing_alg_values_supported: Array<String>
}
