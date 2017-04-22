//
//  RegisterViewController.swift
//  FireCMS
//
//  Created by Salvatore Polito on 25/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var cognomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confermaPasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nomeTextField.delegate = self
        cognomeTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confermaPasswordTextField.delegate = self
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @IBAction func registerAction(_ sender: Any) {
        guard  let nome = nomeTextField.text else {
            return
        }
        
        guard let cognome = cognomeTextField.text else {
            return
        }
        
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        guard let confermaPassword = confermaPasswordTextField.text else {
            return
        }
        
        if password != confermaPassword {
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
            
            let uid = user?.uid
            let ref = FIRDatabase.database().reference()
            let nodo_utenti = ref.child("utenti").child(uid!)
            let conf = [String]()
            let values = ["nome" : nome, "cognome" : cognome, "email" :  email, "conferenze" : conf] as [String : Any]
            
            nodo_utenti.setValue(values)
            
            print("\n Welcome \(user!.email!)")
            
            self.performSegue(withIdentifier: "RegisterToLogin", sender: self)
        })
        
        
    }

}
