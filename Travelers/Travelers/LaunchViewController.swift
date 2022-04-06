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
        
        if signUpButton != nil {
            signUpButton.layer.cornerRadius = 15.0
            signUpButton.layer.masksToBounds = true
        }
        
        if loginButton != nil {
            loginButton.layer.cornerRadius = 15.0
            loginButton.layer.masksToBounds = true
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
