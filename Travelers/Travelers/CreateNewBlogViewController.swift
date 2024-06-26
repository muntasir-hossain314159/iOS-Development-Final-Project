//
//  CreateNewBlogViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/9/22.
//

import UIKit
import Firebase
import FirebaseStorage
import FBSDKLoginKit

class CreateNewBlogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var travelBlogNameTF: UITextField!
    @IBOutlet var travelLocationTF: UITextField!
    @IBOutlet var uploadTravelShotLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var travelDescriptionTV: UITextView!
    @IBOutlet var uploadTravelShotView: UIView!
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Clicking on the Upload Image button displays the Photo Library
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    //Choose an image from the Photo Library and display it on the Create New Blog page
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else {return}
        
        guard let imageData = image.pngData() else {return}
        
        //Create reference folder in Cloud Storage
        let imageRef = storage.child("images/\(imageURL.lastPathComponent)")
        
        //Upload image data (bytes) to a child reference (folder) in Cloud Storage
        imageRef.putData(imageData, metadata: nil) { (_, error) in
            guard error == nil else {
                print("Failed to upload image to Cloud Storage")
                return
            }
            print("Uploaded Image Successfully")
            imageRef.downloadURL(completion: { (url, error) in
                guard let url = url, error == nil else {return}
            
                let urlString = url.absoluteString
                
                UserDefaults.standard.set(urlString, forKey: "url")
                
                self.displayImage()
            })
        }
    }
    
    //Display the chosen image using the download URL
    func displayImage() {
        
        uploadTravelShotView.backgroundColor = .white
        uploadTravelShotLabel.isHidden = true
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString)
        else {return}
        
        print(urlString)
   
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
    
    //Return to Create New Blog page after user presses cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    struct UserData: Codable {
        var first_name: String
        var last_name: String
    }
    
    func retrieveFullNameOfAuthorFromUsersCollection(travelBlogName: String, user_ID: String) {
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
                let travelAuthor = userResult.first_name + " " + userResult.last_name
        
                db.collection("blogs").document("\(travelBlogName + user_ID)").setData(["travel_author": travelAuthor], merge: true) { (err) in
                    if let error = err {
                        print(error.localizedDescription)
                        return
                    }
                    print("Successfully Uploaded all data to Firestore")
                    self.transferToBlogPage(travelBlogName: travelBlogName, user_ID: user_ID)
                }
            case .failure(let error):
                print("Error in retrieving data \(error)")
            }
        }
    }
    
    //Upload the information from the Create New Blog page onto Firestore
    @IBAction func publishBlogButtonTapped(_ sender: Any) {
        let travelBlogName: String = travelBlogNameTF.text!
        let travelLocation: String = travelLocationTF.text!
        let travelDescription: String = travelDescriptionTV.text!
       
        let downloadImageURL: String = UserDefaults.standard.value(forKey: "url") as! String
        guard let user_ID: String = Auth.auth().currentUser?.uid else { return }
            
        //Store Blog information in Firestore
        let db = Firestore.firestore()
        db.collection("blogs").document("\(travelBlogName + user_ID)").setData(["travel_blog_name": travelBlogName, "travel_location": travelLocation, "travel_description": travelDescription, "download_image_url": downloadImageURL]) { (err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            print("Successfully Uploaded Inputted Information to Firestore")
            self.retrieveFullNameOfAuthorFromUsersCollection(travelBlogName: travelBlogName, user_ID: user_ID)
        }
    }
    
    //Navigate to Blog View Controller
    func transferToBlogPage(travelBlogName: String, user_ID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let blogViewController = storyBoard.instantiateViewController(withIdentifier: "blogVC") as! BlogViewController
        blogViewController.documentID = travelBlogName + user_ID
        self.navigationController?.pushViewController(blogViewController, animated: true)
    }
    
    //Navigate to Search View Controller
    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    //Sign Out User
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
    
    //Navigate to Launch View Controller
    func transferToLaunchVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
    

}
