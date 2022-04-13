//
//  ViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/2/22.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var googleSignIn: GIDSignInButton!
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            //User is logged in from previous session
            self.transferToSearchVC()
        } else {
            //No user is signed in
            styleLoginButton()
            setupGoogleButton()
        }
    }
    
    func styleLoginButton() {
        if loginButton != nil {
            loginButton.layer.cornerRadius = 15.0
            loginButton.layer.masksToBounds = true
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let email = emailTF.text!
        let password = passwordTF.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            self.transferToSearchVC()
        }
        
    }
    //Facebook Authentication - Sign in with Facebook after tapping on Button
    @IBAction func facebookSignInTapped(_ sender: Any) {
        let loginManager = LoginManager()
      
        loginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let credentials = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credentials) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Login Successful.")
                    self.transferToSearchVC()
                }
            }
        }
    }
    
    //Google Authentication
    func setupGoogleButton() {
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
                self.transferToSearchVC()
            }
        }
    }
    
    //Navigate to Search View Controller after logging in with a Social Account
    func transferToSearchVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    //Navigate to Launch View Controller when back button is pressed
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }    
}

