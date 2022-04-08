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

class LoginViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    
    @IBOutlet var googleSignIn: GIDSignInButton!
    @IBOutlet var socialAccountStackView: UIStackView!
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButton()
        setupGoogleButton()
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
    //Facebook Authentication
    func setupFacebookButton() {
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.delegate = self
        facebookLoginButton.permissions = ["public_profile","email"]
        socialAccountStackView.addArrangedSubview(facebookLoginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
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
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged Out")
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

