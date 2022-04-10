//
//  CreateNewBlogViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/9/22.
//

import UIKit

class CreateNewBlogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = storyBoard.instantiateViewController(withIdentifier: "searchVC")
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    

}
