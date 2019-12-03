//
//  TokenMethod.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/27/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
enum TokenMethod : CustomStringConvertible {
    
    case CLIENT_SECRET_POST
    case CLIENT_SECRET_BASIC
    case NONE
    
    var description : String {
        switch self {
            case .CLIENT_SECRET_POST: return "CLIENT_SECRET_POST"
            case .CLIENT_SECRET_BASIC: return "CLIENT_SECRET_BASIC"
            case .NONE: return "NONE"
        }
    }
}
