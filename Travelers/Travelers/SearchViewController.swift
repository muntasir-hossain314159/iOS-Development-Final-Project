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
    
     @IBAction func createNewBlogButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "createNewBlogVC")
        self.navigationController?.pushViewController(searchViewController, animated: true)
     }
     

}
