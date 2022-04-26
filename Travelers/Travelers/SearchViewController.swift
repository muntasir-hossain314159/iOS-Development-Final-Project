//
//  SearchViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/9/22.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var searchParameters: UISearchBar!
    
    @IBAction func createNewBlogButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createNewBlogViewController = storyBoard.instantiateViewController(withIdentifier: "createNewBlogVC")
        self.navigationController?.pushViewController(createNewBlogViewController, animated: true)
     }
     
    
    //User Profile Button tapped
    @IBAction func userProfileButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewVC")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
