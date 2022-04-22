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

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Card was tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 3
        return blogArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        /*cell.authorName.text = "Muntasir Hossain"
        cell.blogName.text = "My Adventures"
        cell.location.text = "Dhaka, Bangladesh"
        cell.blogImage.image = UIImage(named: "smoky-autumn-sunset-mountain-range_dp_680")*/
        cell.blogName.text = blogArray[indexPath.row].travel_blog_name
        cell.authorName.text = blogArray[indexPath.row].travel_author
        cell.location.text = blogArray[indexPath.row].travel_location
        displayImageInformation(blogCell: cell, downloadImageURL: blogArray[indexPath.row].download_image_url)
        return cell
    }

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var blogArray = [BlogData] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "BlogCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BlogCell")

        searchBar.delegate = self
        self.hidKeyboardWhenTappedAround()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchValue: String = searchBar.text!
        blogArray.removeAll()
        //self.tableView.reloadData()
        self.searchFirestore(searchValue: searchValue)
    }
    
    func searchFirestore(searchValue: String) {
        let db = Firestore.firestore()
        let blogsRef = db.collection("blogs")
        blogsRef.whereField("travel_location", isGreaterThanOrEqualTo: searchValue)
            .whereField("travel_location", isLessThanOrEqualTo: searchValue + "\u{f8ff}")
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
        var travel_author: String
    }
    
    func retrieveDataFromBlogsCollection(documentID: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("blogs").document(documentID)

        docRef.getDocument(as: BlogData.self) { [self] result in
            switch result {
            case .success(let blogResult):
                self.blogArray.append(blogResult)
                self.tableView.reloadData()
                //self.displayBlogInformation(blog: blogResult)
                print("Successfully Retrieved Blog Data")
            case .failure(let error):
                print("Error in retrieving data \(error)")
            }
        }
    }
  
    
    func displayImageInformation(blogCell: BlogCell, downloadImageURL: String) {
        
        //let locationImage: UIImageView = UIImageView()
        //locationImage.contentMode = .scaleAspectFit
        //locationImage.image = image
        //var image: UIImage
        guard let url = URL(string: downloadImageURL) else {return}

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
          guard let data = data, error == nil else {
              print("Failed to download image")
              return
          }
            
          DispatchQueue.main.async {
              print("Downloading Image")
              let image = UIImage(data: data)!
              blogCell.blogImage.image = image
          }
        }
        
        task.resume()

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
