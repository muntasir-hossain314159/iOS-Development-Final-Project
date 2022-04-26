//
//  BlogViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/13/22.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class BlogViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var travelLocationLabel: UILabel!
    @IBOutlet var travelDescriptionTV: UITextView!
    
    var documentID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataFromUsersCollection()
        retrieveDataFromBlogsCollection()
    }
    
    struct UserData: Codable {
        var first_name: String
        var last_name: String
    }
    
    struct BlogData: Codable {
        var travel_blog_name: String
        var travel_location: String
        var travel_description: String
        var download_image_url: String
    }
    
    func retrieveDataFromUsersCollection() {
        guard let user_ID: String = Auth.auth().currentUser?.uid
        else {
            print("Failed, unable to retrieve user")
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document("\(user_ID)")
        docRef.getDocument(as: UserData.self) { result in
            switch result {
            case .success(let userResult):
                print("Successfully Retrieved User Data")
                self.authorLabel.text = userResult.first_name + " " + userResult.last_name
            case .failure(let error):
                print("Error in retrieving data \(error)")
            }
        }
    }
    
    func retrieveDataFromBlogsCollection() {
        let db = Firestore.firestore()
        let docRef = db.collection("blogs").document("\(documentID)")

        docRef.getDocument(as: BlogData.self) { result in
            switch result {
            case .success(let blogResult):
                print("Successfully Retrieved Blog Data")
                self.setUpBlogPage(blog: blogResult)
            case .failure(let error):
                print("Error in retrieving data \(error)")
            }
        }
    }
    
    func setUpBlogPage(blog: BlogData) {
        titleLabel.text = blog.travel_blog_name
        travelLocationLabel.text = blog.travel_location
        travelDescriptionTV.text = blog.travel_description
        
        guard let url = URL(string: blog.download_image_url) else {return}

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
    
    //User Profile Button tapped
    @IBAction func userProfileButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewVC")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
