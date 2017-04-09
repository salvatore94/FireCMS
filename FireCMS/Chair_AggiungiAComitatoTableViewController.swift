//
//  Chair_AggiungiAComitatoTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 06/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Chair_AggiungiAComitatoTableViewController: UITableViewController {

    var listaUtenti = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.populateListaUtenti(){ (response) in
            self.listaUtenti = response
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
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    func populateListaUtenti(completion: @escaping (([UserClass]) -> Void)) {
        var lista = [UserClass]()
        var count = 0
        FIRDatabase.database().reference().child("utente").observeSingleEvent(of: .value, with: { (snapshot) in
            count = Int(snapshot.childrenCount)
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                        let user = UserClass(_uid: value["uid"] as! String, _email: value["email"] as! String, _nome: value["nome"] as! String, _cognome: value["cognome"] as! String)
                        
                        lista.append(user)
                }
                
                if lista.count == count {
                    completion(lista)
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        conferenza.addRecensore(_toAdd: listaUtenti[indexPath.row].getUid())
        FIRDatabase.database().reference().child("conferenze").child(conferenza.getUid()).setValue(conferenza.getRecensori(), forKey: "recensori")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaUtenti.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AggiungiAComitatoCell", for: indexPath)

        let nome = listaUtenti[indexPath.row].getNome() + " " + listaUtenti[indexPath.row].getCognome()

        cell.textLabel?.text = nome
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}