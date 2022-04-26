//
//  ProfilePageViewController.swift
//  Travelers
//
//  Created by Michael Shea on 4/26/22.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var editPencilButton: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCreateEditPencilButton()
    }
    
    //Function to set Edit Pencil Button view to circle
    func styleCreateEditPencilButton() {
        if editPencilButton != nil {
            editPencilButton.layer.cornerRadius = editPencilButton.layer.bounds.width / 2
            editPencilButton.clipsToBounds = true
        }
    }
    
    //Function to sign a user out when Sign Out Button is tapped
    @IBAction func userSignOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut() //Log out of Firebase, Google, and Facebook
          transferToLaunchVC()
          print("Successfully Logged Out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //Navigate to Create New Blog Controller when button is tapped
    @IBAction func createNewBlogButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createNewBlogViewController = storyBoard.instantiateViewController(withIdentifier: "createNewBlogVC")
        self.navigationController?.pushViewController(createNewBlogViewController, animated: true)
     }
    
    //Navigate to Search View Controller when search button is tapped
    @IBAction func searchButtonTapped(_ sender: Any) {
        transferToSearchVC()
    }
    
    //Navigate to Search View Controller when back button is tapped
    @IBAction func backButton(_ sender: Any) {
        transferToSearchVC()
    }
    
    //Navigate to Launch View Controller
    func transferToLaunchVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
    
    //Navigate to Search View Controller
    func transferToSearchVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
}
