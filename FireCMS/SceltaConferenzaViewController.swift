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
        
        var lista = populateConferencesButton()
        
        
        //conferenza1.setTitle(utente.getListaConferenze()[1], for: .normal)
    }
    

    func populateConferencesButton() -> [ConferenzaClass] {
        var lista = [ConferenzaClass] ()
        for conference in utente.getListaConferenze() {
            FIRDatabase.database().reference().child("conferenze").child(conference).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSDictionary
                
                let title = value["NomeConferenza"] as! String
                self.conferenza1.setTitle(title, for: .normal)
                
                var conf = ConferenzaClass(_nome: value["NomeConferenza"] as! String, _tema: value["TemaConferenza"] as! String, _luogo: value["LuogoConferenza"] as! String, _inizio: value["DataInizio"] as! String, _fine: value["DataFine"] as! String)
                lista.append(conf)
            })
        }
        return lista
    }
    
    //secondo bottone
    @IBOutlet weak var conferenza2Action: UIButton!
    //primo bottone
    @IBOutlet weak var conferenza1Action: UIButton!
    //creaNuovaConferenza
    @IBAction func creaNuovaConferenzaAction(_ sender: Any) {
    }

}
