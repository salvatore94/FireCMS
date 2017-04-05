//
//  Autore_ListaArticoliTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 04/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Autore_ListaArticoliTableViewController: UITableViewController {

    var listaArticoli = [ArticoloClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        super.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.populateListaArticoli(){ (response) in
            self.listaArticoli = response
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
        
        super.tableView.reloadData()
    }
    
    func populateListaArticoli(completion: @escaping (([ArticoloClass]) -> Void)) {
        var lista = [ArticoloClass]()
        var count = 0
        FIRDatabase.database().reference().child("articoli").observeSingleEvent(of: .value, with: { (snapshot) in
            count = Int(snapshot.childrenCount)
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                    if value["autoreUid"] as! String == utente.getUid()  && value["conferenzaUid"] as! String == conferenza.getUid() {
                        let articolo = ArticoloClass(_uid: snap.key, _autoreUid: value["autoreUid"] as! String, _titolo: value["titolo"] as! String, _tema: value["tema"] as! String)
                        print (articolo)
                        lista.append(articolo)
                    }
                }
                
                if lista.count == count {
                    completion(lista)
                }
            }
        })
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaArticoli.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Autore_listaArticoliTableCell", for: indexPath)

        // Configure the cell...
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaArticoli[indexPath.row].getTitolo()
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
