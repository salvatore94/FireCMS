//
//  Chair_ArticoliAddRecensoreTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 09/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Chair_ArticoliAddRecensoreTableViewController: UITableViewController {
    
    var listaRecensori = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.popolaComitato(){ (response) in
            self.listaRecensori = response
            self.tableView.reloadData()
        }
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recensoreUid = listaRecensori[indexPath.row].getUid()
        let articoloUid = articolo.getUid()
        
        let value = ["recensoreUid" : recensoreUid, "articoloUid" : articoloUid as Any, "voto" : 0.0, "commento" : "", "commentoPrivato" : ""] as [String : Any]
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).childByAutoId().setValue(value)
        conferenza.addRecensore(_toAdd: recensoreUid)
    }

    
    func popolaComitato(completion: @escaping (([UserClass]) -> Void)) {
        var listaComitato = [UserClass]()
        let count = conferenza.getRecensori().count
        
        FIRDatabase.database().reference().child("utenti").observeSingleEvent(of: .value, with: { (snapshot) in
            for recensore in conferenza.getRecensori() {
                for child in snapshot.children {
                    if let snap = child as? FIRDataSnapshot {
                        let val = snap.value as! NSDictionary
                        if snap.key == recensore {
                            let user = UserClass(_uid: snap.key, _email: val["email"] as! String, _nome: val["nome"] as! String, _cognome: val["cognome"] as! String)
                            listaComitato.append(user)
                        }
                    }
                    
                    if listaComitato.count == count {
                        completion(listaComitato)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaRecensori.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recensoreCell", for: indexPath)
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaRecensori[indexPath.row]
.getNome() + " " + listaRecensori[indexPath.row].getCognome()
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


}
