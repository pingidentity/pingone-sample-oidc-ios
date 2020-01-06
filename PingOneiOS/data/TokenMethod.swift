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
