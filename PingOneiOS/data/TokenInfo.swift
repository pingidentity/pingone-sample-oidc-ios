struct TokenInfo: Codable {
    let acr: String
    let at_hash: String
    let aud: String
    let auth_time: Int
    let email: String
    let exp: Int
    let given_name: String
    let iat: Int
    let iss: String
    let nonce: String
    let preferred_username: String
    let sub: String
    let updated_at: Int
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label, value) as? (String, Any)
        }).compactMap{ $0 })
        return dict
    }
    
    func mapLabel(label: String) -> String {
        switch label {
            case "at_hash": return "Access Token hash value."
            case "sub": return "User Identifier."
            case "name":return  "User\'s full name."
            case "given_name": return "User given name(s) or first name(s)."
            case "family_name": return "Surname(s) or last name(s) of the User."
            case "middle_name": return "User middle name."
            case "nickname": return "User casual name."
            case "preferred_username": return "User shorthand name."
            case "email": return "User e-mail address."
            case "updated_at": return "Last time User\'s information was updated."
            case "amr": return "Authentication Methods Reference."
            case "iss": return "Response Issuer Identifier."
            case "nonce": return "Client session unique and random value."
            case "aud": return "ID Token Audience."
            case "acr": return "Authentication Context Class Reference."
            case "auth_time": return "User authentication time."
            case "exp": return "ID Token expiration time."
            case "iat": return "Time at which the JWT was issued."
            case "address_country": return "Country name. "
            case "address_postal_code": return "Zip code or postal code. "
            case "address_region": return "State, province, prefecture, or region. "
            case "address_locality": return "City or locality. "
            case "address_formatted": return "Full mailing address. "
            case "address_street_address": return "Full street address. "
            case "amr_0": return "Authentication methods. "
            default: return label
        }
    }
}
