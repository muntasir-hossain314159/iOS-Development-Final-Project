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

class ViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var googleSignIn: GIDSignInButton!
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
        
    }
    
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
        
        let loginButton = FBLoginButton()
              loginButton.delegate = self
              loginButton.center = view.center
              view.addSubview(loginButton)
              loginButton.permissions = ["public_profile","email"]
        
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
          
            //This is where you should add the functionality of successful login
            //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
         if let error = error {
             print(error.localizedDescription)
         return
         }
         let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
         Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
             if let error = error {
                 print("Facebook authentication with Firebase error: ", error)
                 return
             }
         print("Login success with FB!")
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
         self.navigationController?.pushViewController(searchViewController, animated: true)
         }
     }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
         print("Logged out")
      }
    
    

    
    
    
}

