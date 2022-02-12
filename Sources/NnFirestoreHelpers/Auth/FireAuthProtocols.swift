//
//  FireAuthProtocols.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

import FirebaseAuth

// MARK: - UserInfo
public protocol FireAuthUserInfo {
    var userID: String? { get }
    var email: String { get }
    var currentUser: FirebaseAuth.User? { get }
}

// MARK: - Login
public protocol FireLoginAuth {
    func emailSignIn(email: String,
                     password: String,
                     completion: @escaping AuthCompletion)
    func createNewUser(email: String,
                       password: String,
                       completion: @escaping AuthCompletion)
    func guestLogin(completion: @escaping AuthCompletion)
}

// MARK: - Logout
public protocol FireLogoutAuth {
    func logout(completion: @escaping (Error?) -> Void)
}

// MARK: - CredentialLink
public protocol FireLinkCredentialsAuth {
    func linkCredentials(email: String,
                         password: String,
                         completion: @escaping AuthCompletion)
}

// MARK: - ResetPassword
public protocol FireResetPasswordAuth {
    func resetPassword(_ email: String,
                       completion: @escaping (FireNetworkError?) -> Void)
}
