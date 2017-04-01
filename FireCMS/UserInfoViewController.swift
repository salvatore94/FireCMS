//
//  UserInfoViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 27/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            FIRDatabase.database().reference().child("utenti").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let nome = value?["nome"] as? String ?? ""
                let cognome = value?["cognome"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                
                self.nomeLabel.text = nome + " " + cognome
                self.emailLabel.text = email

                }) { (error) in
                    print(error.localizedDescription)
                }
    }

}
