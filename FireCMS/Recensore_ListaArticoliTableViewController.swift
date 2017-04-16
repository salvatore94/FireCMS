//
//  Recensore_ListaArticoliTableViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 15/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

var articoloDaRecensire : ArticoloClass?
var recensioneArticolo : RecensioneClass?

class Recensore_ListaArticoliTableViewController: UITableViewController {

    var listaArticoliAssegnati = [ArticoloClass]()
    var listaRecensioni = [RecensioneClass] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popolaListaRecensioniAssegnati(completion: { (response) in
            self.listaRecensioni = response
            self.popolateListaArticoli(completion: { (response1) in
                self.listaArticoliAssegnati = response1
                self.tableView.reloadData()
            })
        })
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

    func popolaListaRecensioniAssegnati (completion: @escaping (([RecensioneClass]) -> Void)) {
        var lista = [RecensioneClass]()
        var count = 0
        
        FIRDatabase.database().reference().child("recensioni").child(conferenza.getUid()).observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                if let value = snap.value as? NSDictionary {
                    if value["recensoreUid"] as! String == utente.getUid() {
                        let rec = RecensioneClass(_uid: snap.key, _recensoreUid: utente.getUid(), _articoloUid: value["articoloUid"] as! String)
                        lista.append(rec)
                    }
                }
                count = count + 1
                if count == Int(snapshot.childrenCount) {
                    completion(lista)
                }
            }
        })
    }
    
    func popolateListaArticoli (completion: @escaping (([ArticoloClass]) -> Void )) {
        var lista = [ArticoloClass]()
        let count = listaRecensioni.count
        
        FIRDatabase.database().reference().child("articoli").child(conferenza.getUid()).observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! FIRDataSnapshot
                if let value = snap.value as? NSDictionary {
                    for rec in self.listaRecensioni {
                        if snap.key == rec.getArticoloUid() {
                            let arc = ArticoloClass(_uid: rec.getArticoloUid(), _autoreUid: value["autoreUid"] as! String, _titolo: value["titolo"] as! String, _tema: value["tema"] as! String)
                            
                            lista.append(arc)
                        }
                    }
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
        return listaArticoliAssegnati.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Recensore_listaArticoliTableCell", for: indexPath)
        cell.layer.cornerRadius = 10
        
        cell.textLabel?.text = listaArticoliAssegnati[indexPath.row].getTitolo()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cosa fare alla selezione di una cella
        articoloDaRecensire = listaArticoliAssegnati[indexPath.row]
        recensioneArticolo = listaRecensioni[indexPath.row]
        
        performSegue(withIdentifier: "Recensore_DettagliArticolo", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}
