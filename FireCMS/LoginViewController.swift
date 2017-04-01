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

var utente = UserClass()
var conferenza = ConferenzaClass()


class LoginViewController: UIViewController {

    @IBOutlet weak var passwortTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    var handle : FIRAuthStateDidChangeListenerHandle? = nil
    
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
            
                        
            self.performSegue(withIdentifier: "SceltaConferenza", sender: self)
            
            //se Autore
            //self.performSegue(withIdentifier: "AutoreMainView", sender: self)
            
            //se Recensore
            //self.performSegue(withIdentifier: "RecensoerMainView", sender: self)
            
        }
    }

    func popolateUserAccount() -> Void {
        FIRDatabase.database().reference().child("utenti").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            usleep(5000000)
            utente.setNome(_nome: (value?["nome"] as! String ))
            utente.setCognome(_cognome: (value?["cognome"] as! String))
            utente.setEmail(_email: (value?["email"] as! String))
            
            //let dd = ["1" : "test", "2" : "test2"]
            // ref.child("utenti").child(user!.uid).child("conferenza").setValue(dd)
            utente.setConferenze(_conf: value?["conferenza"] as! [String])
            

            print(utente.getListaConferenze())
        }) { (error) in
            print(error.localizedDescription)
        }

    }
}
