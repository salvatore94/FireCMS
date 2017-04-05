//
//  Chair_RecensioniTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 05/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Chair_RecensioniTableViewController: UITableViewController {

    var listaRecensioni = [RecensioneClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateListaArticoli(){ (response) in
            self.listaRecensioni = response
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
    
    func populateListaArticoli(completion: @escaping (([RecensioneClass]) -> Void)) {
        var lista = [RecensioneClass]()
        var count = 0
        FIRDatabase.database().reference().child("articoli").childByAutoId().queryEqual(toValue: conferenza.getUid(), childKey: "conferenzaUid").observeSingleEvent(of: .value, with: { (snapshot) in
            count = Int(snapshot.childrenCount)
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                    let articolo = ArticoloClass(_uid: snap.key, _autoreUid: value["autoreUid"] as! String, _titolo: value["titolo"] as! String, _tema: value["tema"] as! String)
                    
                    //lista.append()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // la dimensione della tabella articoli
        return listaRecensioni.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chair_listaArticoliTableCell", for: indexPath)
        
        cell.layer.cornerRadius = 10
        
       // cell.textLabel?.text = listaRecensioni[indexPath.row].getTitolo()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
