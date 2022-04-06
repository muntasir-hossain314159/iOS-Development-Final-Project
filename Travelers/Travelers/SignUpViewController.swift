//
//  SignUpViewController.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/5/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var createAccountButton: UIButton!
    @IBAction func backButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "launchVC")
        self.navigationController?.pushViewController(launchViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if createAccountButton != nil {
            createAccountButton.layer.cornerRadius = 15.0
            createAccountButton.layer.masksToBounds = true
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
