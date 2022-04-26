//
//  ProfileEditViewController.swift
//  Travelers
//
//  Created by Michael Shea on 4/26/22.
//

import UIKit

class ProfileEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //Navigate to Profile Page View Controller when back button is pressed
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
}
