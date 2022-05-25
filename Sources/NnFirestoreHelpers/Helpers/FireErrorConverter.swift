//
//  FireErrorConverter.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

import FirebaseAuth

public final class FireErrorConverter {
    private init() { }
    
    static func convertError(_ error: Error) -> FireNetworkError {
        let code = AuthErrorCode(rawValue: error._code)
        print("error:", error)
        print("errorCode:", code ?? "unknown code")
        return getFireError(code)
    }
    
    private static func getFireError(_ errorCode: AuthErrorCode?) -> FireNetworkError {
        guard let errorCode = errorCode else { return .unknown }
        
        switch errorCode {
        case .wrongPassword:
            return .wrongPassword
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .invalidEmail:
            return .invalidEmail
        case .networkError:
            return .badConnection
        case .userNotFound:
            return .userNotFound
        case .credentialAlreadyInUse:
            return .credentialAlreadyInUse
        case .weakPassword:
            return .weakPassword
        case .tooManyRequests:
            return .tooManyRequests
        default:
            return .unknown
        }
    }
}


