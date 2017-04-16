//
//  Recensore_SottomettiRecensioneViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 15/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Recensore_SottomettiRecensioneViewController: UIViewController {

    @IBOutlet weak var titoloArticoloLabel: CustomPaddedLabel!
    
    @IBOutlet weak var votoField: UITextField!
    
    @IBOutlet weak var commentoField: UITextField!
    
    @IBOutlet weak var commentoPrivatoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titoloArticoloLabel.text = articoloDaRecensire?.getTitolo()
    }

    @IBAction func sottomettiAction(_ sender: Any) {
        guard let voto =  Double(votoField.text!) else {
            return
        }
        
        recensioneArticolo?.setVoto(_voto: voto)
        recensioneArticolo?.setCommento(_commento: commentoField.text ?? "")
        recensioneArticolo?.setCommentoPrivato(_commentoPrivato: commentoPrivatoField.text ?? "")
        
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).child((recensioneArticolo?.getUid())!).removeValue()
        
        let value = ["recensoreUid" : recensioneArticolo?.getRecensoreUid(), "articoloUid" : recensioneArticolo?.getArticoloUid(), "voto" : recensioneArticolo?.getVoto(), "commento" : recensioneArticolo?.getCommento(), "commentoPrivato" : recensioneArticolo?.getCommentoPrivato()] as [String : Any]
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).child((recensioneArticolo?.getUid())!).setValue(value)
    }
}
