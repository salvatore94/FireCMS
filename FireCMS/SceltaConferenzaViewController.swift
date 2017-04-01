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

    var lista = [ConferenzaClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        conferenza1.isEnabled = false
        conferenza2.isEnabled = false
        
        lista = populateConferencesButton()
        
        conferenza1.setTitle(lista[1].getNomeConferenza(), for: .normal)
        conferenza2.setTitle(lista[2].getNomeConferenza(), for: .normal)

    }
    

    func populateConferencesButton() -> [ConferenzaClass] {
        var lista = [ConferenzaClass] ()
        for conference in utente.getListaConferenze() {
            FIRDatabase.database().reference().child("conferenze").child(conference).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSDictionary
                
                let title = value["NomeConferenza"] as! String
                self.conferenza1.setTitle(title, for: .normal)
                
                var conf = ConferenzaClass(_nome: value["NomeConferenza"] as! String, _tema: value["TemaConferenza"] as! String, _luogo: value["LuogoConferenza"] as! String, _inizio: value["DataInizio"] as! String, _fine: value["DataFine"] as! String)
                conf.setChairUid(_chairUid: value["ChairUid"] as! String)
                
                lista.append(conf)
            }) { (error) in
                print(error.localizedDescription)
            }

        }
        return lista
    }
    @IBAction func conferenza1Action(_ sender: Any) {
        conferenza.setUid(_uid: lista[1].getUid())
        conferenza.setNomeConferenza(_nome: lista[1].getNomeConferenza())
        conferenza.setTemaConferenza(_tema: lista[1].getTemaConferenza())
        conferenza.setLuogoConferenza(_luogo: lista[1].getLuogoConferenza())
        conferenza.setInizioConferenza(_inizio: lista[1].getInizioConferenza())
        conferenza.setFineConferenza(_fine: lista[1].getFineConferenza())
        conferenza.setChairUid(_chairUid: lista[1].getChairUid())
    }
    
    @IBAction func conferenza2Action(_ sender: Any) {
        conferenza.setUid(_uid: lista[2].getUid())
        conferenza.setNomeConferenza(_nome: lista[2].getNomeConferenza())
        conferenza.setTemaConferenza(_tema: lista[2].getTemaConferenza())
        conferenza.setLuogoConferenza(_luogo: lista[2].getLuogoConferenza())
        conferenza.setInizioConferenza(_inizio: lista[2].getInizioConferenza())
        conferenza.setFineConferenza(_fine: lista[2].getFineConferenza())
        conferenza.setChairUid(_chairUid: lista[2].getChairUid())
    }
    
    //creaNuovaConferenza
    @IBAction func creaNuovaConferenzaAction(_ sender: Any) {
        performSegue(withIdentifier: "CreaNuovaConferenza", sender: self)
    }

    func definisciRuolo() -> Void {
        let userUid = utente.getUid()
        let chairUid = conferenza.getChairUid()
        let conferenceUid = conferenza.getUid()
        
        if userUid == chairUid {
            performSegue(withIdentifier: "ChairMainView", sender: self)
            return
        }
    
        FIRDatabase.database().reference().child("Comitato").child(conferenceUid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let values = snapshot.value as! [String]
            
            for value in values {
                if value == userUid {
                    self.performSegue(withIdentifier: "RecensoreMainView", sender: self)
                    return
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }

        
        FIRDatabase.database().reference().child("Articoli").child(conferenceUid).queryOrdered(byChild: "AutoreArticolo").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let values = snapshot.value as! [String]
            
            for value in values {
                if value == userUid {
                    self.performSegue(withIdentifier: "AutoreMainView", sender: self)
                    return
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }

        
        
    }
}
