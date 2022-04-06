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
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.delegate = self
        facebookLoginButton.permissions = ["public_profile","email"]
        socialAccountStackView.addArrangedSubview(facebookLoginButton)

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
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
            self.navigationController?.pushViewController(searchViewController, animated: true)
            //self.show(searchViewController, sender: self)
            //self.present(searchViewController, animated: true, completion: nil)
            }
        }
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
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
            self.navigationController?.pushViewController(searchViewController, animated: true)
            
            //self.show(searchViewController, sender: self)
            //self.present(searchViewController, animated: true, completion: nil)
          
            //This is where you should add the functionality of successful login
            //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged Out")
    }
    
}

