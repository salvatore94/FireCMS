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
    var handle : FIRAuthStateDidChangeListenerHandle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = (FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            self.navigationItem.title = user?.email
            })!
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
       do {
            try! FIRAuth.auth()?.signOut()

        } catch let error as NSError {
            print(error)
        }
 
        performSegue(withIdentifier: "login", sender: self)
    }
}
