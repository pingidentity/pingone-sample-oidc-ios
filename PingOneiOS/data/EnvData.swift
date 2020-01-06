struct EnvData:Decodable {
    let environment_id: String
    let client_id: String
    let redirect_uri: String
    let authorization_scope: String
    let discovery_uri: String
    let application_uri: String
    let token_method: String
    let client_secret: String
}
