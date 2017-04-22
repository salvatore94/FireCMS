//
//  CreaConferenzaViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 31/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class CreaConferenzaViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nomeField: UITextField!
    @IBOutlet weak var temaField: UITextField!
    @IBOutlet weak var luogoField: UITextField!
    @IBOutlet weak var inizioField: UITextField!
    @IBOutlet weak var fineField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nomeField.delegate = self
        temaField.delegate = self
        luogoField.delegate = self
        inizioField.delegate = self
        fineField.delegate = self
        
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
        conferenza.setChairUid(_chairUid: (FIRAuth.auth()?.currentUser?.uid)!)

        
        let values = ["NomeConferenza" : conferenza.getNomeConferenza(), "TemaConferenza" : conferenza.getTemaConferenza(), "LuogoConferenza" : conferenza.getLuogoConferenza(), "DataInizio" : conferenza.getInizioConferenza(), "DataFine" : conferenza.getFineConferenza(), "ChairUid" : conferenza.getChairUid()] as [String : Any]
        
        let key = FIRDatabase.database().reference().child("conferenze").childByAutoId().key
        
        FIRDatabase.database().reference().child("conferenze").child(key).setValue(values)
            conferenza.setUid(_uid: key)
            utente.addConferenza(_toAdd: key)
            
        FIRDatabase.database().reference().child("utenti").child((FIRAuth.auth()?.currentUser?.uid)!).child("conferenza").setValue(utente.getListaConferenze() as [Any])
        

        
        performSegue(withIdentifier: "SceltaConferenzaDaCrea", sender: self)
    }

}
