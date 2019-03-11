//
//  SignupVC.swift
//  TaxiRider
//
//  Created by PowerMobile on 4/2/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController {

    private let segue = "signupSegue"
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    //outltess
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func seguePerform(){
        activityIndicator.stopAnimating()
        performSegue(withIdentifier: segue, sender: self)
        
    }
    
    func alertUser (title: String, message: String){
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnSignup(_ sender: UIButton) {
        
        if let email = emailTxt.text, let password = passwordTxt.text {
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            self.activityIndicator.color = UIColor.red
//            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    print("Error while user creating\(firebaseError.localizedDescription)")
                    
                    self.alertUser(title: "Error", message: "\(firebaseError.localizedDescription)")
                    
                  
                    self.activityIndicator.stopAnimating()

                    return
                } else{
                    print("successfuly created new user")
                    if user?.uid != nil {
                        
                        DBProvider.instance.saveUser(withID: user!.uid, email: email, password: password)
                        
                        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                            if let err = error {
                                print("Error while login\(err.localizedDescription)")
                                self.alertUser(title: "Error", message: "\(err.localizedDescription)")
                                self.activityIndicator.stopAnimating()
                                return
                            }
                        })
                        self.seguePerform()

                    }
                }
                
                
            })
        }
        
    }
    
    
    @IBAction func btnSignupWithGoogle(_ sender: UIButton) {
    }
    
    @IBOutlet weak var btnSignupWithFacebook: UIButton!
    
    

}
