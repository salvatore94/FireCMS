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


class Chair_ArticoliTableViewController: UITableViewController {
    
    var handle : FIRAuthStateDidChangeListenerHandle? = nil
    var numeroArticoli = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = (FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            let ref = FIRDatabase.database().reference()
            let nodo_utenti = ref.child("articoli")
            
            //numeroArticoli =
        })
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // la dimensione della tabella articoli
        return numeroArticoli
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chair_listaArticoliTableCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

}
