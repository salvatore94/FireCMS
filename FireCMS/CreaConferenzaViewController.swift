//
//  CreaConferenzaViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 31/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class CreaConferenzaViewController: UIViewController {
    @IBOutlet weak var nomeField: UITextField!
    @IBOutlet weak var temaField: UITextField!
    @IBOutlet weak var luogoField: UITextField!
    @IBOutlet weak var inizioField: UITextField!
    @IBOutlet weak var fineField: UITextField!

    
    let ref = FIRDatabase.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func creaAction(_ sender: Any) {
        guard let nome = nomeField.text else {
            return
        }
        guard let tema = temaField.text else {
            return
        }
        guard let luogo = luogoField.text else {
            return
        }
        guard let inizio = inizioField.text else {
            return
        }
        guard let fine = fineField.text else {
            return
        }
        
        conferenza.setNomeConferenza(_nome: nome)
        conferenza.setTemaConferenza(_tema: tema)
        conferenza.setLuogoConferenza(_luogo: luogo)
        conferenza.setInizioConferenza(_inizio: inizio)
        conferenza.setFineConferenza(_fine: fine)
        
        
        let nodo = ref.child("conferenze")
        
        let values = ["NomeConferenza" : conferenza.getNomeConferenza(), "TemaConferenza" : conferenza.getTemaConferenza(), "LuogoConferenza" : conferenza.getLuogoConferenza(), "DataInizio" : conferenza.getInizioConferenza(), "DataFine" : conferenza.getFineConferenza(), "ChairUid" : conferenza.getChairUid()]
        
        let key = nodo.childByAutoId().key
        nodo.child(key).setValue(values)
        
        print(key)
        utente.addConferenza(_toAdd: key)
        
        performSegue(withIdentifier: "SceltaConferenzaDaCrea", sender: self)
    }

}
