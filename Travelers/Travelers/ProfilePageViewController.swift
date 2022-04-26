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
    @IBOutlet weak var squareImage: UIImageView!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    @IBOutlet weak var userTravelInfo: UILabel!
    
    var documentID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        styleCreateEditPencilButton()
        styleCreateImageCircle()
//        retrieveUserData()
    }
    
//    struct UserData: Codable {
//        var first_name: String
//        var last_name: String
//        var email: String
//        var password: String
//        var travel_info: String
//
//        init(fname: String = "", lname: String = "", email: String = "", pass: String = "", tinfo: String = ""){
//            self.first_name = fname
//            self.last_name = lname
//            self.email = email
//            self.password = pass
//            self.travel_info = tinfo
//        }
//    }
//
//    func retrieveUserData(){
//        guard let user_ID: String = Auth.auth().currentUser?.uid
//        else {
//            print("Failed, unable to retrieve user")
//            return
//        }
//
//        let db = Firestore.firestore()
//        let docRef = db.collection("users").document("\(user_ID)")
//        docRef.getDocument(as: UserData.self) { result in
//            switch result {
//            case .success(let userResult):
//                print("Successfully Retrieved User Data")
//                self.userFirstName.text = userResult.first_name
//                self.userLastName.text = userResult.last_name
//                self.userEmail.text = userResult.email
//                self.userPassword.text = userResult.password
//                self.userTravelInfo.text = userResult.travel_info
//            case .failure(let error):
//                print("Error in retrieving data \(error)")
//            }
//        }
//    }
    
    //Function to set Image to circle view
    func styleCreateImageCircle() {
        if squareImage != nil {
            squareImage.layer.cornerRadius = squareImage.frame.size.width / 2
            squareImage.layer.masksToBounds = true
            squareImage.layer.borderWidth = 2
            squareImage.layer.borderColor = UIColor.black.cgColor
        }
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
    
    //Navigate to Edit Profile View Controller when button is tapped
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "profileEditVC")
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
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
