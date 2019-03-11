//
//  DBProvider.swift
//  TaxiDriver
//
//  Created by PowerMobile on 4/3/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    
    private static let _instance = DBProvider()
    
    static var instance: DBProvider {
        return _instance
    }
    
    var dbRef : DatabaseReference {
        return Database.database().reference()
    }
    
    var riderRef : DatabaseReference {
        return dbRef.child(Constance.RIDER)
    }
    
    var requestRef : DatabaseReference {
        return dbRef.child(Constance.UBER_REQUEST)
    }
    
    var requestAcceptedRef : DatabaseReference {
        return dbRef.child(Constance.UBER_ACCEPTED)
    }
    
    
    func saveUser(withID: String, email: String, password: String){
        let data : Dictionary<String, Any> = [Constance.EMAIL: email, Constance.PASSWORD : password, Constance.isRider : true ]
        riderRef.child(withID).child(Constance.DATA).setValue(data)
        
    }
    
    
    
}
