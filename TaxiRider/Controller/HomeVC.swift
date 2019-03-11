//
//  HomeVC.swift
//  TaxiDriver
//
//  Created by PowerMobile on 4/2/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate ,UberController{
    
    
  
    
    @IBOutlet weak var requestOutlet: ButtonStyles!
    
    @IBOutlet weak var mapView: MKMapView!
    //variables
    private var locationManager = CLLocationManager()
    private var userLocation : CLLocationCoordinate2D?
    private var driverLocation : CLLocationCoordinate2D?
    
    private var timer = Timer()
    private var canCallUber = true
    private var riderCancledRequest = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLocationManager()
        RiderHandler.Instance.observeMessageForRider()
        RiderHandler.Instance.delegate = self
    }
    
    func initializeLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate{
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            mapView.removeAnnotations(mapView.annotations)
            if driverLocation != nil {
                if !canCallUber {
                    let driverAnnotation = MKPointAnnotation()
                    driverAnnotation.coordinate = driverLocation!
                    driverAnnotation.title = "Driver Location"
                    mapView.addAnnotation(driverAnnotation)
                }
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation!
            annotation.title = "Driver Location"
            mapView.addAnnotation(annotation)
            
        }
    }//locationManager
    
    @objc func updateRiderLocation(){
        RiderHandler.Instance.updateRiderLocation(lat: userLocation!.latitude, long: userLocation!.longitude)
    }
    
    func canCallUber(delegateCalled: Bool) {
        if delegateCalled {
            requestOutlet.setTitle("CANCEL", for: UIControlState.normal)
            canCallUber = false
        }else {
            requestOutlet.setTitle("REQUEST", for: UIControlState.normal)
            canCallUber = true
        }
    }
    
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String) {
        if !riderCancledRequest {
            if requestAccepted {
                alertUser(title: "Request Accepted", message: "\(driverName) Accepted your request")
            } else {
                RiderHandler.Instance.cancelRequest()
                timer.invalidate()
                alertUser(title: "Canceled request", message: "\(driverName) Cancled your request")
                
            }
        }
        riderCancledRequest = false
    }
    
    func updateDriverLocation(lat: Double, long: Double) {
        driverLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
    }
    
    
    
    
    func alertUser (title: String, message: String){
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
   
    func seguePerform(){
        
        
        if AuthProvider.Instance.logOut() {
            
            if !canCallUber{
                RiderHandler.Instance.cancelRequest()
                timer.invalidate()

            }

            dismiss(animated: true, completion: nil)
        } else {
            alertUser(title: "Error Logout", message: "Could not logout at the moment please tyr later")
        }
        
    }
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
    seguePerform()
    }
    
    @IBAction func requestAction(_ sender: Any) {
    
        if userLocation != nil {
            if canCallUber {
                  RiderHandler.Instance.requestTaxi(latitude: Double(userLocation!.latitude), longitude: Double(userLocation!.longitude))
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(HomeVC.updateRiderLocation), userInfo: nil, repeats: true)
            } else {
                riderCancledRequest = true
                RiderHandler.Instance.cancelRequest()
                timer.invalidate()
            }
        }
        
    }
    
    
}
