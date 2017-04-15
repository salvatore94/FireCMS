//
//  Chair_RecensioniTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 05/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

var recensione = RecensioneClass()

class Chair_RecensioniTableViewController: UITableViewController {

    var listaRecensioni = [RecensioneClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateListaRecensioni(completion: { (response) in
            self.listaRecensioni = response
            self.tableView.reloadData()
        }
)
        
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
    
    func populateListaRecensioni(completion: @escaping (([RecensioneClass]) -> Void)) {
        var lista = [RecensioneClass]()
        var count = 0
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
            count = Int(snapshot.childrenCount)
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                        let recensione = RecensioneClass(_uid: snap.key, _recensoreUid: value["recensoreUid"] as! String, _articoloUid: value["articoloUid"] as! String)
                    
                            if value["voto"] as! Double != 0 {
                                recensione.setVoto(_voto: value["voto"] as! Double)
                            }
                            if value["commento"] as! String != "" {
                                recensione.setCommento(_commento: value["commento"] as! String)
                            }
                            if value["commentoPrivato"] as! String != "" {
                                recensione.setCommentoPrivato(_commentoPrivato: value["commentoPrivato"] as! String)
                            }
                    
                        lista.append(recensione)
                }
                
                if lista.count == count {
                    completion(lista)
                }
            }
        })

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // la dimensione della tabella articoli
        return listaRecensioni.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recensioniTableCell", for: indexPath)
        
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaRecensioni[indexPath.row].getUid()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        
        recensione = listaRecensioni[indexPath.row]
        
        performSegue(withIdentifier: "DettagliRecensione", sender: self)
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
