struct UserInfo: Codable {
    let email: String
    let given_name: String
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
            case "email": return "User email address."
            case "given_name": return "User given name."
            case "preferred_username":return  "User\'s full name."
            case "sub": return "User Identifier."
            case "updated_at": return "Last time User\'s information was updated."
            default: return label
        }
    }
}
