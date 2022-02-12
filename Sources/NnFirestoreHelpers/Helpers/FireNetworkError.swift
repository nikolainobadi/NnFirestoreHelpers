//
//  NetworkError.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

enum NetworkError: Error {
    
    case wrongPassword
    case emailAlreadyInUse
    case invalidEmail
    case networkError
    case userNotFound
    case credentialAlreadyInUse
    case weakPassword
    
    case dataNotFound
    
    case shortUsername
    case usernameTaken
    case tooManyRequests
    
    case badURL
    case updateFail
    case deleteFail
    case badConnection
    case unknown
    case decodeError
}


// MARK: - Message
extension NetworkError {
    
    var message: String {
        switch self {
        case .wrongPassword:
            return "You entered the wrong password."
        case .emailAlreadyInUse:
            return "That email is already in use. Please try another."
        case .invalidEmail:
            return "That is NOT a valid email address."
        case .networkError:
            return "Poor network connection, please try again later."
        case .userNotFound:
            return "Sorry, that user data is missing."
        case .credentialAlreadyInUse:
            return "Looks like those credentials are already in use. Please use different information to link your account."
        case .weakPassword:
            return "Hit the gym because that password is WEAK. It needs to be at lease 6 characters long"
        
        case .dataNotFound:
            return "Looks like your data is corrupt or missing."
        
        case .shortUsername:
            return "Usernames must be at least 4 characters long."
        case .usernameTaken:
            return "That username is already taken. Please choose another."
        case .tooManyRequests:
            return "If you don't remember your password, it's ok, just reset it by tapping 'Forgot Password'. Otherwise, you have to wait like 30 minutes from now before you can login even if you enter the correct password."
        
        case .badURL:
            return "Bad URL"
        case .updateFail:
            return "Update failed"
        case .deleteFail:
            return "Delete failed"
        case .badConnection:
            return "Bad internet connection"
        case .unknown:
            return "unknown network error"
        case .decodeError:
            return "Unable to decode data"
        }
    }
}

