//
//  Chair_ArticoliRecensoriAssegnatiTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 09/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class Chair_ArticoliRecensoriAssegnatiTableViewController: UITableViewController {

    var listaRecensoriAssegnati = [String]()
    var listaUtenti = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaRecensoriAssegnati = populateListaRecensoriAssegnati()
        
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
    
    @IBAction func addRecensoreAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "AddRecensoreTable", sender: self)
    }
    
    
    func populateListaRecensoriAssegnati() -> [String] {
        var lista = [String]()
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                    if value["articoloUid"] as! String == articolo?.getUid() {
                    let recensore = value["recensoreUid"] as! String
                        
                        
                    lista.append(recensore)
                    }
                }

            }
        })
        
        return lista
    }

    func popolaListaUtenti() -> [UserClass] {
        var lista = [UserClass]()
        
        FIRDatabase.database().reference().child("utenti").observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                for uid in self.listaRecensoriAssegnati {
                    if snap.key == uid {
                        let value = snap as! NSDictionary
                        let user = UserClass(_uid: snap.key, _email: value["email"] as! String, _nome: value["nome"] as! String, _cognome: value["cognome"] as! String)
                        
                        lista.append(user)
                    }
                }
            }
        })
        
        return lista
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaRecensoriAssegnati.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recensoriCell", for: indexPath)

        cell.textLabel?.text = listaUtenti[indexPath.row].getNome() + " " + listaUtenti[indexPath.row].getCognome()

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
}
