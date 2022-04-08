//
//  LaunchViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/5/22.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSignUpButton()
        styleLoginButton()

    }
    
    func styleSignUpButton() {
        if signUpButton != nil {
            signUpButton.layer.cornerRadius = 15.0
            signUpButton.layer.masksToBounds = true
        }
    }
    
    func styleLoginButton() {
        if loginButton != nil {
            loginButton.layer.cornerRadius = 15.0
            loginButton.layer.masksToBounds = true
        }
    }
    

   

}
