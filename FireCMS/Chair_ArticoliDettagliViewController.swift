
//
//  Chair_ArticoliDettagliViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 09/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase


class Chair_ArticoliDettagliViewController: UIViewController {

    
    
    @IBOutlet weak var titoloField: CustomPaddedLabel!
    
    
    @IBOutlet weak var temaField: CustomPaddedLabel!
   
    
    @IBOutlet weak var autoreField: CustomPaddedLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titolo = articolo.getTitolo()
        let tema = articolo.getTema()
        
        self.trovaAutore(completion: { (response) in
            self.autoreField.text = response.getNome() + " " + response.getCognome()
        })
        
        
        titoloField.text = titolo
        temaField.text = tema
        
        //let autoreUid = articolo?.getAutoreUid()
        //let autore = trovaAutore(_uid: autoreUid!)
        //autoreField.text = autore.getNome() + " " + autore.getCognome()
        
    }

    func trovaAutore(completion: @escaping ((UserClass) -> Void)) {
        let autore = UserClass()
        let uid = articolo.getAutoreUid()
        var count = 0
        
        FIRDatabase.database().reference().child("utenti").observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                if snap.key == uid {
                    let value = snap.value as! NSDictionary
                    autore.setUid(_uid: snap.key)
                    autore.setNome(_nome: value["nome"] as! String )
                    autore.setCognome(_cognome: value["cognome"] as! String)
                    autore.setEmail(_email: value["email"] as! String)
                    
                    count =  1
                }
                if count == 1 {
                    completion(autore)
                }
            }
        })

    }

    @IBAction func chiudi(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
