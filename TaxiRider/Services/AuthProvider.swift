//
//  AuthProvider.swift
//  TaxiDriver
//
//  Created by PowerMobile on 4/2/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthProvider {
    private static let _instance = AuthProvider()
    
    static var Instance: AuthProvider {
        return _instance
    }
    
    func logOut() -> Bool{
//        print("logot user \(String(describing: Auth.auth().currentUser))")
        if Auth.auth().currentUser != nil
        {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false
            }
        }
        return true
    }
  
    
    
    
    
}
