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
        
        self.populateListaRecensoriAssegnati(){ (response) in
            self.listaRecensoriAssegnati = response
            self.popolaListaUtenti(completion: { (response1) in
                self.listaUtenti = response1
                self.tableView.reloadData()
            })
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
    
    @IBAction func addRecensoreAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "AddRecensoreTable", sender: self)
    }
    
    
    func populateListaRecensoriAssegnati(completion: @escaping (([String]) -> Void)) {
        var lista = [String]()
        let uid = articolo.getUid()
        var count = 0
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in (snapshot.children) {
                let snap = child as! FIRDataSnapshot
                
                if let value = snap.value as? NSDictionary {
                    if (value["articoloUid"] as! String) == uid {
                        lista.append(value["recensoreUid"] as! String)
                    }
                }
                
                count = count + 1
                if Int(snapshot.childrenCount) == count {
                    completion(lista)
                }
            }
        })

    }

    func popolaListaUtenti(completion: @escaping (([UserClass]) -> Void)) {
        var lista = [UserClass]()
        let recensori = self.listaRecensoriAssegnati
        var count = 0
        
        FIRDatabase.database().reference().child("utenti").observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                for uid in recensori {
                    if snap.key == uid {
                        if let value = snap.value as? NSDictionary {
                            let user = UserClass(_uid: snap.key, _email: value["email"] as! String, _nome: value["nome"] as! String, _cognome: value["cognome"] as! String)
                        
                        lista.append(user)
                    }
                  }
                }
                count = count + 1
                if Int(snapshot.childrenCount) == count {
                    completion(lista)
                }
            }
        })

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "recensoreInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recensoreInfo" {
            let rootcontroller = segue.destination as! UINavigationController
            let controller = rootcontroller.viewControllers.first as! RecensoreInfoViewController

            let index  = tableView.indexPathForSelectedRow?.row
            
            let nome = listaUtenti[index!].getNome() + " " + listaUtenti[index!].getCognome()
            let email = listaUtenti[index!].getEmail()
            controller.setNomeLabel(_nome: nome)
            controller.setEmailLabel(_email: email)
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaUtenti.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recensoriCell", for: indexPath)

        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaUtenti[indexPath.row].getNome() + " " + listaUtenti[indexPath.row].getCognome()

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
