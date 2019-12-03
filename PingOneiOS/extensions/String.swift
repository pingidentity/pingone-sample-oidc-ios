//
//  String.swift
//  PingOneiOS
//
//  Created by Vadym Kovalskyi on 9/29/19.
//  Copyright © 2019 Vadym Kovalskyi. All rights reserved.
//
import UIKit

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

extension String: Error {}
