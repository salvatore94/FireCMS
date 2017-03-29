//
//  SceltaConferenzaViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 29/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class SceltaConferenzaViewController: UIViewController {

    @IBOutlet weak var conferenza1: UIButton!
    @IBOutlet weak var conferenza2: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        conferenza1.isEnabled = false
        conferenza2.isEnabled = false
            let ref = FIRDatabase.database().reference()
            utente.setUid(_uid: (FIRAuth.auth()!.currentUser!.uid))
                
            ref.child("utenti").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
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
    

    
    //secondo bottone
    @IBOutlet weak var conferenza2Action: UIButton!
    //primo bottone
    @IBOutlet weak var conferenza1Action: UIButton!
    //creaNuovaConferenza
    @IBAction func creaNuovaConferenzaAction(_ sender: Any) {
    }

}
