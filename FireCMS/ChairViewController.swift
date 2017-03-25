//
//  ChairViewController.swift
//  FireCMS
//
//  Created by Salvatore Polito on 25/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ChairViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logoutAction(_ sender: Any) {
       /* do {
            try! FIRAuth.auth()?.signOut()

        } catch let error as NSError {
            print(error)
        }
 */
        performSegue(withIdentifier: "login", sender: self)
    }
}
