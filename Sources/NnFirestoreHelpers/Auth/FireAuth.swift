//
//  FireAuth.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

import FirebaseAuth

public final class FireAuth {
    
    // MARK: - Properties
    private let auth = Auth.auth()
    
    public var userID: String? { auth.currentUser?.uid }
    public var email: String { auth.currentUser?.email ?? "" }
}


// MARK: - LoginAuth
extension FireAuth: FireLoginAuth {
    
    public func emailSignIn(email: String,
                     password: String,
                     completion: @escaping AuthCompletion) {
        
        auth.signIn(withEmail: email,
                    password: password,
                    completion: handleAuthResult(completion))
    }
    
    public func createNewUser(email: String,
                       password: String,
                       completion: @escaping AuthCompletion) {
        
        auth.createUser(withEmail: email,
                        password: password,
                        completion: handleAuthResult(completion))
    }
    
    public func guestLogin(completion: @escaping AuthCompletion) {
        auth.signInAnonymously(completion: handleAuthResult(completion))
    }
}
 


// MARK: - CredentialLink Auth
extension FireAuth: FireLinkCredentialsAuth  {
    
    public func linkCredentials(email: String,
                         password: String,
                         completion: @escaping AuthCompletion) {

        let credentials = EmailAuthProvider.credential(withEmail: email,
                                                       password: password)
        auth.currentUser?.link(with: credentials,
                               completion: handleAuthResult(completion))
    }
}


// MARK: - Logout
extension FireAuth: FireLogoutAuth {

    public func logout(completion: @escaping (Error?) -> Void) {
        do {
            try auth.signOut(); completion(nil)
        } catch {
            completion(error)
        }
    }
}


// MARK: - ResetPassword Auth
extension FireAuth: FireResetPasswordAuth {

    public func resetPassword(_ email: String,
                       completion: @escaping (NetworkError?) -> Void) {

        auth.sendPasswordReset(withEmail: email) { error in
            guard let error = error else { return completion(nil) }

            completion(FireErrorConverter.convertError(error))
        }
    }
}


// MARK: - Private Methods
private extension FireAuth {
    
    func handleAuthResult(_ completion: @escaping (Result<FirebaseAuth.User, NetworkError>) -> Void) -> ((AuthDataResult?, Error?) -> Void) {
        
        return { (authData, error) in
            if let error = error {
                completion(.failure(FireErrorConverter.convertError(error)))
            } else {
                guard
                    let user = authData?.user
                else { return completion(.failure(NetworkError.userNotFound)) }

                completion(.success(user))
            }
        }
    }
}


// MARK: - Dependencies
public typealias AuthCompletion = ((Result<FirebaseAuth.User, NetworkError>) -> Void)

