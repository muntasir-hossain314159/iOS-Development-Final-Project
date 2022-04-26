//
//  ProfileEditViewController.swift
//  Travelers
//
//  Created by Michael Shea on 4/26/22.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var editPencilButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCreateEditPencilButton()
        self.view.bringSubviewToFront(editPencilButton)

    }
    
    //Function to set Edit Pencil Button view to circle
    func styleCreateEditPencilButton() {
        if editPencilButton != nil {
            editPencilButton.layer.cornerRadius = editPencilButton.layer.bounds.width / 2
            editPencilButton.clipsToBounds = true
        }
    }

    //Navigate to Profile Page View Controller when back button is pressed
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewVC")
        self.navigationController?.pushViewController(profileViewController, animated: true)
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
