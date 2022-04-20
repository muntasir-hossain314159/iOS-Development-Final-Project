//
//  SearchViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/9/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FBSDKLoginKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var blogCardVS: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.hidKeyboardWhenTappedAround()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchValue: String = searchBar.text!
        self.searchFirestore(searchValue: searchValue)
    }
    
    func searchFirestore(searchValue: String) {
        let db = Firestore.firestore()
        let blogsRef = db.collection("blogs")
        blogsRef.whereField("travel_location", isGreaterThanOrEqualTo: searchValue)
            .getDocuments { (queryResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                else {
                    for document in queryResult!.documents {
                        print(document.documentID)
                        self.retrieveDataFromBlogsCollection(documentID: document.documentID)
                    }
                }
            }
    }
    
    struct BlogData: Codable {
        var travel_blog_name: String
        var travel_location: String
        var travel_description: String
        var download_image_url: String
    }
    
    func retrieveDataFromBlogsCollection(documentID: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("blogs").document(documentID)

        docRef.getDocument(as: BlogData.self) { result in
            switch result {
            case .success(let blogResult):
                print("Successfully Retrieved Blog Data")
                self.displayBlogInformation(blog: blogResult)
            case .failure(let error):
                print("Error in retrieving data \(error)")
            }
        }
    }
  
    
    func displayBlogInformation(blog: BlogData) {
        
        let locationImage: UIImageView = UIImageView()
        locationImage.contentMode = .scaleAspectFill
        
        guard let url = URL(string: blog.download_image_url) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
          guard let data = data, error == nil else {
              print("Failed to download image")
              return
          }
          DispatchQueue.main.async {
              print("Downloading Image")
              let image: UIImage = UIImage(data: data)!
              locationImage.image = image
          }
        }

        task.resume()
        
        blogCardVS.addArrangedSubview(locationImage)
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

extension SearchViewController {
    func hidKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
