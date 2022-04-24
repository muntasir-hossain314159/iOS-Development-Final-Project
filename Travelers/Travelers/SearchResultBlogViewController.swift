//
//  SearchResultBlogViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/24/22.
//

import UIKit
import Firebase

class SearchResultBlogViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var travelLocationLabel: UILabel!
    @IBOutlet var travelDescriptionTV: UITextView!
    
    var travel_blog_name: String = ""
    var travel_author: String = ""
    var travel_location: String = ""
    var travel_description: String = ""
    var download_image_url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBlogPage()
    }
    
    func setUpBlogPage() {
        titleLabel.text = travel_blog_name
        authorLabel.text = travel_author
        travelLocationLabel.text = travel_location
        travelDescriptionTV.text = travel_description
        
        guard let url = URL(string: download_image_url) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
          guard let data = data, error == nil else {
              print("Failed to download image")
              return
          }
          DispatchQueue.main.async {
              print("Downloading Image")
              let image: UIImage = UIImage(data: data)!
              self.travelImageView.image = image
          }
        }

        task.resume()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @IBAction func createNewBlogButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createNewBlogViewController = storyBoard.instantiateViewController(withIdentifier: "createNewBlogVC")
        self.navigationController?.pushViewController(createNewBlogViewController, animated: true)
     }
    
    @IBAction func userProfileButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut() //Log out of Firebase, Google, and Facebook
          transferToLaunchVC()
          print("Successfully Logged Out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func transferToLaunchVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
}
