//
//  ViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/2/22.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var googleSignIn: GIDSignInButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if signUpButton != nil {
            signUpButton.layer.cornerRadius = 15.0
            signUpButton.layer.masksToBounds = true
        }
        
        if loginButton != nil {
            loginButton.layer.cornerRadius = 15.0
            loginButton.layer.masksToBounds = true
        }
        
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
        print(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
            print(error.localizedDescription)
            } else {
            print("Login Successful.")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "search")
            self.navigationController?.pushViewController(searchViewController, animated: true)
                //self.show(searchViewController, sender: self)
            //self.present(searchViewController, animated: true, completion: nil)
          
            //This is where you should add the functionality of successful login
            //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
}

