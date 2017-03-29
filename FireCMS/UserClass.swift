//
//  UserClass.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 29/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import Foundation
import Firebase

class UserClass {
    var uid : String?
    var nome : String?
    var cognome : String?
    var email : String?
    var listaConferenze = [String]()
    
    init() {
        
    }
    
    init(_uid: String, _email: String, _nome: String, _cognome: String) {
        uid = _uid
        nome = _nome
        cognome = _cognome
        email = _email
    }
    
    func getUid() -> String {
        return uid!
    }
    func getNome() -> String {
        return nome!
    }
    func getCognome() -> String {
        return cognome!
    }
    func getEmail() -> String {
        return email!
    }
    func getListaConferenze() -> [String] {
        return listaConferenze
    }
    func addConferenza(_toAdd: String) -> Void {
        listaConferenze.append(_toAdd)
    }
    func setConferenze(_conf : [String]) -> Void {
        for conferences in _conf {
            listaConferenze.append(conferences)
        }
    }
    func setNome(_nome: String) -> Void {
        nome = _nome
    }
    func setCognome(_cognome: String) -> Void {
        cognome = _cognome
    }
    func setEmail(_email : String) -> Void {
        email = _email
    }
    func setUid(_uid : String) -> Void {
        uid = _uid
    }
}
