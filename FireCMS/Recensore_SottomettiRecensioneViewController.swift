//
//  Recensore_SottomettiRecensioneViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 15/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Recensore_SottomettiRecensioneViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titoloArticoloLabel: CustomPaddedLabel!
    
    @IBOutlet weak var votoField: UITextField!
    
    @IBOutlet weak var commentoField: UITextField!
    
    @IBOutlet weak var commentoPrivatoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titoloArticoloLabel.text = articoloDaRecensire?.getTitolo()
        
        votoField.delegate = self
        commentoField.delegate = self
        commentoPrivatoField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func sottomettiAction(_ sender: Any) {
        guard let voto =  Double(votoField.text!) else {
            return
        }
        
        recensioneArticolo?.setVoto(_voto: voto)
        recensioneArticolo?.setCommento(_commento: commentoField.text ?? "")
        recensioneArticolo?.setCommentoPrivato(_commentoPrivato: commentoPrivatoField.text ?? "")
        
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).child((recensioneArticolo?.getUid())!).removeValue()
        
        let value = ["recensoreUid" : recensioneArticolo?.getRecensoreUid() as Any, "articoloUid" : recensioneArticolo?.getArticoloUid() as Any, "voto" : recensioneArticolo?.getVoto() as Any, "commento" : recensioneArticolo?.getCommento() as Any, "commentoPrivato" : recensioneArticolo?.getCommentoPrivato() as Any] as [String : Any]
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).child((recensioneArticolo?.getUid())!).setValue(value)
    }
}
