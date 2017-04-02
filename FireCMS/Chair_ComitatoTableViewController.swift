//
//  Chair_ComitatoTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 02/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

var comitato = [UserClass]()

class Chair_ComitatoTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        comitato = popolaComitato()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comitato.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComitatoCell", for: indexPath)
        
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
    
    
    func popolaComitato() -> [UserClass] {
        var comitato = [UserClass] ()
        FIRDatabase.database().reference().child("comitati").child(conferenza.getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let values = snapshot.value as! [String]
            
            for value in values {
                FIRDatabase.database().reference().child("utenti").child(value).observeSingleEvent(of: .value, with: { (snapshot) in
                    let dati = snapshot.value as! NSDictionary
                    
                    let recensore = UserClass(_uid: value, _email: dati["email"] as! String, _nome: dati["nome"] as! String, _cognome: dati["cognome"] as! String)
                    
                    comitato.append(recensore)
                }) { (error) in
                    print(error.localizedDescription)
                }

            }
        }) { (error) in
            print(error.localizedDescription)
        }

        
        return comitato
    }

}
