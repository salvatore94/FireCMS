//
//  Autore_SottmettiViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 04/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Autore_SottmettiViewController: UIViewController {

    @IBOutlet weak var titoloTextField: UITextField!
    @IBOutlet weak var temaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func sottomettiAction(_ sender: Any) {
        guard let titolo = titoloTextField.text else {
            return
        }
        guard let tema = temaTextField.text else {
            return
        }
        
        let articolo = ArticoloClass()
        articolo.setTitolo(_titolo: titolo)
        articolo.setTema(_tema: tema)
        
        let value = ["autoreUid" : utente.getUid(), "titolo" : titolo, "tema" : tema]
        let key = FIRDatabase.database().reference().child("articoli").child(conferenza.getUid()).childByAutoId().key
        
        FIRDatabase.database().reference().child("articoli").child(conferenza.getUid()).child(key).setValue(value)
            conferenza.addAutore(_toAdd: utente.getUid())
            FIRDatabase.database().reference().child("conferenze").child(conferenza.getUid()).child("autori").setValue(conferenza.getAutori())
        
        
        

        let alertVC = UIAlertController(title: "Successo", message: "Articolo Sottomesso", preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            print("ok")
        })
        alertVC.addAction(okButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func caricaFileAction(_ sender: Any) {
        
    }

}
