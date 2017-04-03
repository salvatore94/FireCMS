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
        
        //add background blur  
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func populateListaConferenze(completion: @escaping (([ConferenzaClass]) -> Void)) {
        var lista = [ConferenzaClass]()
        let count = utente.getListaConferenze().count
        for conference in utente.getListaConferenze() {
            FIRDatabase.database().reference().child("conferenze").child(conference).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    
                    let conf = ConferenzaClass(_uid: conference, _nome: value["NomeConferenza"] as! String, _tema: value["TemaConferenza"] as! String, _luogo: value["LuogoConferenza"] as! String, _chairUid: value["ChairUid"] as! String, _inizio: value["DataInizio"] as! String, _fine: value["DataFine"] as! String)
                    
                    lista.append(conf)
                }
                if lista.count == Int(count) {
                    completion(lista)
                }
            })
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        performSegue(withIdentifier: "", sender: self)
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

        cell.textLabel?.text = listaConferenze[indexPath.row].getNomeConferenza()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
