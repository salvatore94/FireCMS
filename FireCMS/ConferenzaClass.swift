//
//  ConferenzaClass.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 31/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import Foundation

class ConferenzaClass {
    private var uid : String
    private var chairUid : String
    private var nome : String
    private var tema : String
    private var luogo : String
    private var inizio : String
    private var fine : String
    
    init() {
        uid = ""
        chairUid = ""
        nome = ""
        tema = ""
        luogo = ""
        inizio = ""
        fine = ""
    }
    
    init(_nome: String, _tema: String, _luogo: String, _inizio: String, _fine: String) {
        uid = ""
        chairUid = ""
        nome = _nome
        tema = _tema
        luogo = _luogo
        inizio = _inizio
        fine = _fine
    }
    
    func setChairUid(_chairUid: String) -> Void {
        chairUid = _chairUid
    }
    
    func getChairUid() -> String {
        return chairUid
    }
    
    func setUid(_uid: String){
        uid = _uid
    }
    
    func setNomeConferenza(_nome: String) -> Void {
        nome = _nome
    }
    
    func setTemaConferenza(_tema: String) -> Void {
        tema = _tema
    }
    
    func setLuogoConferenza(_luogo: String) -> Void {
        luogo = _luogo
    }
    
    func setInizioConferenza(_inizio: String) -> Void {
        inizio = _inizio
    }
    
    func setFineConferenza(_fine: String) -> Void {
        fine = _fine
    }
    
    func getUid() -> String {
        return uid
    }
    
    func getNomeConferenza() -> String {
        return nome
    }
    
    func getTemaConferenza() -> String {
        return tema
    }
    
    func getLuogoConferenza() -> String {
        return luogo
    }
    
    func getInizioConferenza() -> String {
        return inizio
    }
    
    func getFineConferenza() -> String {
        return fine
    }
}
