//
//  LoginVC.swift
//  TaxiRider
//
//  Created by PowerMobile on 4/2/18.
//  Copyright © 2018 PowerMobile. All rights reserved.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class LoginVC: UIViewController {

    
    
    //outless
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    private let segue = "loginSegue"
    
    
    
    //Vaiables
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func seguePerfom(){
        activityIndicator.stopAnimating()
        performSegue(withIdentifier: segue, sender: nil)
        
    }
    
    //Actions
    @IBAction func btnLogin(_ sender: UIButton) {
       // if passwordTxt.text != "" && emailTxt.text != "" {
            if let email = emailTxt.text, let password = passwordTxt.text {
//                self.activityIndicator.center = self.view.center
//                self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//                self.activityIndicator.color = UIColor.red
//                self.activityIndicator.hidesWhenStopped = true
////                self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//                self.view.addSubview(self.activityIndicator)
//                self.activityIndicator.startAnimating()
//                // UIApplication.shared.beginIgnoringInteractionEvents()
              
                let view = NVActivityIndicatorView(frame: CGRect(x: Int((self.view.frame.size.width/2) - 50), y: Int((self.view.frame.size.height/2) - 50), width: 100, height: 100))
                view.type = .ballClipRotateMultiple
                view.color = UIColor.red
                view.startAnimating()
                self.view.addSubview(view)
                
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let firebaseSigninError = error {
                        print("Error while login\(firebaseSigninError.localizedDescription)")
                        let alert = UIAlertController(title: "ERROR!", message: "\(firebaseSigninError.localizedDescription)", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.activityIndicator.stopAnimating()
                        view.stopAnimating()
                        self.present(alert, animated: true)
                        return
                    }
                    
                    print("successfuly login")
                    view.stopAnimating()
                    RiderHandler.Instance.rider = self.emailTxt.text!
                    self.seguePerfom()
                })
        }
    }
    
    @IBAction func btnLoginWithGoogle(_ sender: UIButton) {
    }
    @IBAction func btnLoginWithFacebook(_ sender: UIButton) {
    }
    
    @IBAction func btnForgetPassword(_ sender: Any) {
    }
    
}
