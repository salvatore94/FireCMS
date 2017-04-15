//
//  Chair_RecensioneDettagliViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 09/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Chair_RecensioneDettagliViewController: UIViewController {

    @IBOutlet weak var titoloField: CustomPaddedLabel!
    
    @IBOutlet weak var votoField: CustomPaddedLabel!
    
    @IBOutlet weak var commentoField: CustomPaddedLabel!
    
    @IBOutlet weak var commentoPrivatoField: CustomPaddedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titoloField.text = ""
        votoField.text = "\(recensione.getVoto())"
        commentoField.text = recensione.getCommento()
        commentoPrivatoField.text = recensione.getCommentoPrivato()
    }

    @IBAction func chiudiAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func titoloArticolo() -> String {
        var titolo = ""
        
        FIRDatabase.database().reference().child("articoli").child(conferenza.getUid()).observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                if snap.key == recensione.getArticoloUid() {
                    let value = snap.value as! NSDictionary
                    titolo = value["titolo"] as! String
                }
            }
        
        })
        
        return titolo
    }
}
