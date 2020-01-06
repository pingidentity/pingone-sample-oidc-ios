import Alamofire
import KeychainSwift
import JWTDecode
import CommonCrypto

class AuthConfigUtil {
    
    static let shared = AuthConfigUtil()
    
    var configData: EnvData?
    var authData: AuthData?
    var accessCode: String?
    let codeVerifier = AuthConfigUtil.generateCodeVerifier()
    
    private init(){}
    
    func setUP(completion: @escaping (Bool) -> Void ) throws {
        configData = readConfig()
        if configData != nil {
            obtainAuthConfig { data, error in
                if error == nil {
                    self.authData = data
                    completion(true)
                }
            }
        } else {
            throw "Environment not set! Please add auth_config.json"
        }
    }
    
    func getAccessCode() -> AccessCode? {
        let keychain = KeychainSwift()
        let decoder = JSONDecoder()
        let data = keychain.get("access_code")!.data(using: .utf8)!
        let accessCode = try? decoder.decode(AccessCode.self, from: data)
        return accessCode
    }
    
    func saveAccessCode(accessToken: AccessCode) {
        let keychain = KeychainSwift()
        let encoder = JSONEncoder()
        let data = try? encoder.encode(accessToken)
        
        keychain.set(data!, forKey: "access_code")
    }
    
    func deleteAccessCode() {
        let keychain = KeychainSwift()
        keychain.delete("access_code")
        keychain.clear()
    }
    
    func isUserAuthorized() -> Bool {
        let keychain = KeychainSwift()
        return keychain.get("access_code") != nil
    }
    
    func getJWT() -> TokenInfo {
        let jwt = try? decode(jwt: getAccessCode()!.id_token)
        return TokenInfo(
            acr: jwt?.body["acr"] as! String,
            at_hash: jwt?.body["at_hash"] as! String,
            aud: jwt?.body["aud"] as! String,
            auth_time: jwt?.body["auth_time"] as! Int,
            email: jwt?.body["email"] as! String,
            exp: jwt?.body["exp"] as! Int,
            given_name: jwt?.body["given_name"] as! String,
            iat: jwt?.body["iat"] as! Int,
            iss: jwt?.body["iss"] as! String,
            nonce: jwt?.body["iss"] as! String,
            preferred_username: jwt?.body["preferred_username"] as! String,
            sub: jwt?.body["sub"] as! String,
            updated_at: jwt?.body["updated_at"] as! Int
        )
    }
    
    private func readConfig() -> EnvData? {
           if let configURL = Bundle.main.url(forResource: "auth_config", withExtension: "json") {
               if let data =  try? Data(contentsOf: configURL) {
                   let decoder = JSONDecoder()
                   let config  = try? decoder.decode(EnvData.self, from: data)
                   return config
               }
           }
           return nil
    }
    
    private static func generateCodeVerifier() -> String {
        var buffer = [UInt8](repeating: 0, count: 64)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        let codeVerifier = Data(bytes: buffer)
            .base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: "=", with: "-")
            .trimmingCharacters(in: .whitespaces)
            
        return codeVerifier
    }
    
    func generateCodeChallenge() -> String? {
        guard let data = codeVerifier.data(using: .utf8) else { return nil }
        var buffer = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &buffer)
        }
        let hash = Data(bytes: buffer)

        
        let challenge = hash.base64EncodedString()
            
        .replacingOccurrences(of: "+", with: "-")
        .replacingOccurrences(of: "/", with: "_")
        .replacingOccurrences(of: "=", with: "")
        .trimmingCharacters(in: .whitespaces)
        
        return challenge
    }
    
    private static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func obtainAuthConfig(completion: @escaping (AuthData?, AFError?) -> Void) {
        let url = String(format: configData!.discovery_uri, configData!.environment_id)

        AF.request(url, method: .get)
            .responseDecodable { (response: DataResponse<AuthData, AFError>) in
            guard (response.error == nil) else {
                print("Error while gathering auth config: \(String(describing: response.error))")
                completion(nil, response.error)
                return
            }

            let decoder = JSONDecoder()
            let authConfig  = try? decoder.decode(AuthData.self, from: response.data!)
            completion(authConfig, nil)
        }
    }
}
