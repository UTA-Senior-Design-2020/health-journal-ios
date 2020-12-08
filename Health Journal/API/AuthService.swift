//
//  AuthService.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 12/7/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredientials {
    let email: String
    let password: String
    //let fullname: String
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential credentials: AuthCredientials, completion: @escaping(Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data: [String: Any] = ["email": credentials.email,
                                       "uid": uid]
            
            //He Explains this around 6:30 in "Register User in Firebase" easy to understand once you look at firebase
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
}
