//
//  TaxiHandler.swift
//  TaxiRider
//
//  Created by PowerMobile on 4/4/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class  {
    func canCallUber(delegateCalled: Bool)
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String)
    func updateDriverLocation(lat: Double, long: Double)
}


class RiderHandler {
    
    private static let _instance = RiderHandler()
    weak var delegate : UberController?
    
    var rider = ""
    var driver = ""
    var rider_id = ""
    
    static var Instance : RiderHandler {
        return _instance
    }
    
    func observeMessageForRider(){
        //rider request
        DBProvider.instance.requestRef.observe(DataEventType.childAdded) { (snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constance.NAME] as? String {
                    if name == self.rider {
                        self.rider_id = snapshot.key
                        self.delegate?.canCallUber(delegateCalled: true)
                        print("Ther value of rider_id is \(self.rider_id)")
                    }
                }
            }
        }
        
        //rider cancel the request
        DBProvider.instance.requestRef.observe(DataEventType.childRemoved) { (snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constance.NAME] as? String {
                    if name == self.rider {
                        self.delegate?.canCallUber(delegateCalled: false)
                        print("Ther value of rider_id is \(self.rider_id)")
                    }
                }
            }
        }
        
        DBProvider.instance.requestAcceptedRef.observe(DataEventType.childAdded) { (snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constance.NAME]  as? String {
                    if self.driver == "" {
                        self.driver = name
                        self.delegate?.driverAcceptedRequest(requestAccepted: true, driverName: name)
                        
                    }
                }
            }
            //driver updating location
            DBProvider.instance.requestAcceptedRef.observe(DataEventType.childChanged, with: { (snapshot : DataSnapshot) in
                if let data = snapshot.value as? NSDictionary {
                    if let name = data[Constance.NAME] as? String{
                        if name == self.driver {
                            if let lat = data[Constance.LATITUDE] as? Double{
                                if let long = data[Constance.LONGITUED] as? Double {
                                    self.delegate?.updateDriverLocation(lat: lat, long: long)
                                }
                            }
                        }
                    }
                }
            })
        }
        DBProvider.instance.requestAcceptedRef.observe(DataEventType.childRemoved) { (snapshot : DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constance.NAME] as? String {
                    if name == self.driver {
                        self.driver = ""
                        self.delegate?.driverAcceptedRequest(requestAccepted: false, driverName: name)
                        
                    }
                }
            }
        }
        
        
    }
    func requestTaxi(latitude: Double, longitude: Double){
        let data : Dictionary<String, Any> = [Constance.NAME : rider, Constance.LATITUDE : latitude, Constance.LONGITUED : longitude]
        DBProvider.instance.requestRef.childByAutoId().setValue(data)
    }//request uber
    
    func cancelRequest(){
        DBProvider.instance.requestRef.child(rider_id).removeValue()
    }
    func updateRiderLocation(lat: Double, long: Double){
        DBProvider.instance.requestRef.child(rider_id).updateChildValues([Constance.LATITUDE : lat, Constance.LONGITUED : long])
    }
    
}
