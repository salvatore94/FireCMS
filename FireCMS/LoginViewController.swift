//
//  LoginViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 25/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var passwortTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func register(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwortTextField.text else {
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                let alertVC = UIAlertController(title: "Errore", message: "Riempire i campi di testo!", preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    print("ok")
                })
            
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            
            let ref = FIRDatabase.database().reference()
            let nodo_utenti = ref.child("utenti")
            let values = ["email" :  email]
            
            nodo_utenti.setValue(values)
            
            print("\n Welcome \(user!.email!)")
        })
        

    }
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwortTextField.text else {
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                let alertVC = UIAlertController(title: "Errore", message: "Errore di login", preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    print("ok")
                })
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
                return
            }
            
            //se Chair
            self.performSegue(withIdentifier: "ChairMainView", sender: self)
            
            //se Autore
            //self.performSegue(withIdentifier: "AutoreMainView", sender: self)
            
            //se Recensore
            //self.performSegue(withIdentifier: "RecensoerMainView", sender: self)
            
        }
    }

    
}
