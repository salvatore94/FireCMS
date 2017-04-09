//
//  ArticoliTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 27/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var articolo : ArticoloClass?

class Chair_ArticoliTableViewController: UITableViewController {
    
    var listaArticoli = [ArticoloClass]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateListaArticoli(){ (response) in
            self.listaArticoli = response
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
    
    func populateListaArticoli(completion: @escaping (([ArticoloClass]) -> Void)) {
        var lista = [ArticoloClass]()
        var count = 0
        FIRDatabase.database().reference().child("articoli").child(conferenza.getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
            count = Int(snapshot.childrenCount)
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                        let articolo = ArticoloClass(_uid: snap.key, _autoreUid: value["autoreUid"] as! String, _titolo: value["titolo"] as! String, _tema: value["tema"] as! String)
                    
                        lista.append(articolo)
                }
                
                if lista.count == count {
                    completion(lista)
                }
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // la dimensione della tabella articoli
        return listaArticoli.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chair_listaArticoliTableCell", for: indexPath)

        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaArticoli[indexPath.row].getTitolo()


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        articolo = listaArticoli[indexPath.row]
        performSegue(withIdentifier: "ChairArticoloSelected", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

}
