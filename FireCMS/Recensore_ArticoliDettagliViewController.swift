//
//  Recensore_ArticoliDettagliViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 15/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Recensore_ArticoliDettagliViewController: UIViewController {

    @IBOutlet weak var titoloField: CustomPaddedLabel!
    
    @IBOutlet weak var temaField: CustomPaddedLabel!
    
    @IBOutlet weak var autoreField: CustomPaddedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titolo = articoloDaRecensire?.getTitolo()
        let tema = articoloDaRecensire?.getTema()
        
        
        
        titoloField.text = titolo
        temaField.text = tema
        
        //let autoreUid = articoloDaRecensire?.getAutoreUid()
        //let autore = trovaAutore(_uid: autoreUid!)
        //autoreField.text = autore.getNome() + " " + autore.getCognome()
        
    }
    
    func trovaAutore(_uid: String) -> UserClass {
        let autore = UserClass()
        FIRDatabase.database().reference().child("utenti").observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                if snap.key == _uid {
                    let value = snap.value as! NSDictionary
                    autore.setUid(_uid: snap.key)
                    autore.setNome(_nome: value["nome"] as! String )
                    autore.setCognome(_cognome: value["cognome"] as! String)
                    autore.setEmail(_email: value["email"] as! String)
                }
            }
        })
        
        return autore
    }

    @IBAction func chiudiAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
