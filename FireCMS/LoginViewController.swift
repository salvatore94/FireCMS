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
    
    var listaConferenze : [ConferenzaClass]?
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
        }
            
           self.popolateUserAccount()
            // Eseguo il segue all'interno della funzione popolateUserAccount() in modo da poter 
            // aspettare che la chiamata asincrona venga portata a termine
    }
    
    
    func popolateUserAccount() {

        FIRDatabase.database().reference().child("utenti").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
            
            utente.setUid(_uid: FIRAuth.auth()!.currentUser!.uid)
            utente.setNome(_nome: (value["nome"] as! String ))
            utente.setCognome(_cognome: (value["cognome"] as! String))
            utente.setEmail(_email: (value["email"] as! String))
            
            //let dd = ["1" : "test", "2" : "test2"]
            // ref.child("utenti").child(user!.uid).child("conferenza").setValue(dd)

            let lista = value["conferenza"] as! [String]
            for conference in lista {
                utente.addConferenza(_toAdd: conference)
            }
                
            self.performSegue(withIdentifier: "SceltaConferenza", sender: self)
            
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
