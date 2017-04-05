//
//  SceltaConferenzaTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 03/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class SceltaConferenzaTableViewController: UITableViewController {

    var listaConferenze = [ConferenzaClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateListaConferenze(){ (response) in
            self.listaConferenze = response
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //set up background
        let backgroundImage = UIImage(named: "register_background.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tableView.backgroundView = imageView

        // no lines where there aren't cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        /*
        //add background blur  
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func creaNuovaConferenzaAction(_ sender: Any) {
        performSegue(withIdentifier: "CreaNuovaConferenza", sender: self)
    }

    
    func populateListaConferenze(completion: @escaping (([ConferenzaClass]) -> Void)) {
        var lista = [ConferenzaClass]()
        var count = 0
        FIRDatabase.database().reference().child("conferenze").observeSingleEvent(of: .value, with: { (snapshot) in
                count = Int(snapshot.childrenCount)
  
                    for child in (snapshot.children) {
                        let snap = child as! FIRDataSnapshot
                        if let value = snap.value as? NSDictionary {
                        let conf = ConferenzaClass(_uid: snap.key, _nome: value["NomeConferenza"] as! String, _tema: value["TemaConferenza"] as! String, _luogo: value["LuogoConferenza"] as! String, _chairUid: value["ChairUid"] as! String, _inizio: value["DataInizio"] as! String, _fine: value["DataFine"] as! String)
                        
                    lista.append(conf)
                }
                        
                if lista.count == count {
                    completion(lista)
                }
            }
        })
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        self.definisciConferenza(_indice: indexPath.row)
        
        self.definisciRuolo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AutoreMainView" {
            let Tabcontroller = segue.destination as! UITabBarController
            let controllers = Tabcontroller.viewControllers
            for controller in controllers! {
                if controller.restorationIdentifier == "info" {
                    let infoController = controller as! UserInfoViewController
                    infoController.setNomeLabel(_nome: utente.getNome())
                    infoController.setEmailLabel(_email: utente.getEmail())
                }
            }
        }
    }

    
    func definisciRuolo() -> Void {
        let userUid = utente.getUid()
        let chairUid = conferenza.getChairUid()
        let conferenceUid = conferenza.getUid()
        
        if userUid == chairUid {
            performSegue(withIdentifier: "ChairMainView", sender: self)
            return
        }
        
      FIRDatabase.database().reference().child("Recensioni").childByAutoId().queryEqual(toValue: conferenceUid, childKey: "idConferenza").observeSingleEvent(of: .value, with: { (snapshot) in
        for child in snapshot.children {
            let snap = child as! FIRDataSnapshot

            if let value = snap.value as? NSDictionary {
                if (value["idRecensore"] as! String) == userUid {
                    self.performSegue(withIdentifier: "RecensoreMainView", sender: self)
                    return
                }
            }
        }
      }) { (error) in
            print(error.localizedDescription)
    }
      
    FIRDatabase.database().reference().child("Articoli").childByAutoId().queryEqual(toValue: conferenceUid, childKey: "idConferenza").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                    if (value["idAutore"] as! String) == userUid {
                    self.performSegue(withIdentifier: "AutoreMainView", sender: self)
                    return
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func definisciConferenza(_indice: Int) -> Void {
        conferenza.setUid(_uid: listaConferenze[_indice].getUid())
        conferenza.setNomeConferenza(_nome: listaConferenze[_indice].getNomeConferenza())
        conferenza.setTemaConferenza(_tema: listaConferenze[_indice].getTemaConferenza())
        conferenza.setLuogoConferenza(_luogo: listaConferenze[_indice].getLuogoConferenza())
        conferenza.setInizioConferenza(_inizio: listaConferenze[_indice].getInizioConferenza())
        conferenza.setFineConferenza(_fine: listaConferenze[_indice].getFineConferenza())
        conferenza.setChairUid(_chairUid: listaConferenze[_indice].getChairUid())
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaConferenze.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SceltaConferenzaTableCell", for: indexPath)
        
        //cell.textLabel?.layer.backgroundColor = UIColor(red: 0/255, green: 159/255, blue: 184/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaConferenze[indexPath.row].getNomeConferenza()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
