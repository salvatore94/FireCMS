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

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lista = populateConferencesArray()

    }
    

    func populateConferencesArray() -> [ConferenzaClass] {
        var lista = [ConferenzaClass]()
        for conference in utente.getListaConferenze() {
            FIRDatabase.database().reference().child("conferenze").child(conference).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                
                    let conf = ConferenzaClass(_uid: conference, _nome: value["NomeConferenza"] as! String, _tema: value["TemaConferenza"] as! String, _luogo: value["LuogoConferenza"] as! String, _chairUid: value["ChairUid"] as! String, _inizio: value["DataInizio"] as! String, _fine: value["DataFine"] as! String)
                
                lista.append(conf)
                print(conf.getUid())
                self.presentButton(_conf: conf)
                }
                
            })
        }
        return lista
    }
    
    func presentButton(_conf: ConferenzaClass) {
        conferenza1.setTitle(_conf.getNomeConferenza(), for: .normal)
    }
    
    @IBAction func conferenza1Action(_ sender: Any) {
        conferenza.setUid(_uid: lista[0].getUid())
        conferenza.setNomeConferenza(_nome: lista[0].getNomeConferenza())
        conferenza.setTemaConferenza(_tema: lista[0].getTemaConferenza())
        conferenza.setLuogoConferenza(_luogo: lista[0].getLuogoConferenza())
        conferenza.setInizioConferenza(_inizio: lista[0].getInizioConferenza())
        conferenza.setFineConferenza(_fine: lista[0].getFineConferenza())
        conferenza.setChairUid(_chairUid: lista[0].getChairUid())
        
        definisciRuolo()
    }
    
    @IBAction func conferenza2Action(_ sender: Any) {
        conferenza.setUid(_uid: lista[1].getUid())
        conferenza.setNomeConferenza(_nome: lista[1].getNomeConferenza())
        conferenza.setTemaConferenza(_tema: lista[1].getTemaConferenza())
        conferenza.setLuogoConferenza(_luogo: lista[1].getLuogoConferenza())
        conferenza.setInizioConferenza(_inizio: lista[1].getInizioConferenza())
        conferenza.setFineConferenza(_fine: lista[1].getFineConferenza())
        conferenza.setChairUid(_chairUid: lista[1].getChairUid())
        
        definisciRuolo()
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
