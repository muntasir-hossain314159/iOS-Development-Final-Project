//
//  SignUpViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/5/22.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var createAccountButton: UIButton!
    
    @IBOutlet var firstNameTF: UITextField!
    
    @IBOutlet var lastNameTF: UITextField!
    
    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCreateAccountButton()
    }
    
    func styleCreateAccountButton() {
        if createAccountButton != nil {
            createAccountButton.layer.cornerRadius = 15.0
            createAccountButton.layer.masksToBounds = true
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let firstName: String = firstNameTF.text!
        let lastName: String = lastNameTF.text!
        let email: String = emailTF.text!
        let password: String = passwordTF.text!
        
        //Create User Account
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            //Failed to create User in Firebase
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            //Store User information in Firestore
            let db = Firestore.firestore()
            db.collection("users").document("\(result!.user.uid)").setData(["first_name": firstName, "last_name": lastName]) { (err) in
                //Failed to add User information to Firestore
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                //Navigate to Search View Controller
                self.transferToSearchVC()
            }
        }
    }
    
    //Navigate to Search View Controller when Create Account button is pressed
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
