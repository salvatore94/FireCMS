//
//  Chair_ComitatoTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 02/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase


class Chair_ComitatoTableViewController: UITableViewController {

    var comitato = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popolaComitato(){ (response) in
            self.comitato = response
            self.tableView.reloadData()
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

        
        
        //set up background
        let backgroundImage = UIImage(named: "register_background.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tableView.backgroundView = imageView
        
        
        
        // no lines where there aren't cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    
    @IBAction func aggiungiAComitatoAction(_ sender: Any) {
        self.performSegue(withIdentifier: "AggiungiAComitato", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comitato.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComitatoCell", for: indexPath)
        cell.layer.cornerRadius = 10
        
        let nome = comitato[indexPath.row].getNome() + " " + comitato[indexPath.row].getCognome()
        
        cell.textLabel?.text = nome
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella

        performSegue(withIdentifier: "recensoreInfo", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recensoreInfo" {
            let controller = segue.destination as! UserInfoViewController
                controller.enableChiudi()
                let index  = tableView.indexPathForSelectedRow?.row
            
                let nome = comitato[index!].getNome() + " " + comitato[index!].getCognome()
                let email = comitato[index!].getEmail()
                controller.setNomeLabel(_nome: nome)
                controller.setEmailLabel(_email: email)
            
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    
    func popolaComitato(completion: @escaping (([UserClass]) -> Void)) {
        var listaComitato = [UserClass] ()
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

}
