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
    
    private var recensori : [String]
    private var autori : [String]
    
    private var nome : String
    private var tema : String
    private var luogo : String
    private var inizio : String
    private var fine : String
    private var scadenzaSottomissione : String
    private var scadenzaReview : String
    private var scadenzaRivisti : String
    
    init() {
        uid = ""
        chairUid = ""
        
        recensori = [String]()
        autori = [String]()
        
        nome = ""
        tema = ""
        luogo = ""
        inizio = ""
        fine = ""
        
        scadenzaSottomissione = ""
        scadenzaReview = ""
        scadenzaRivisti = ""
    }
    
    init(_uid: String, _nome: String, _tema: String, _luogo: String, _chairUid: String, _inizio: String, _fine: String) {
        uid = _uid
        chairUid = _chairUid
        
        recensori = [String]()
        autori = [String]()
        
        nome = _nome
        tema = _tema
        luogo = _luogo
        inizio = _inizio
        fine = _fine
        
        scadenzaSottomissione = ""
        scadenzaReview = ""
        scadenzaRivisti = ""
    }
    
    func setUid(_uid: String){
        uid = _uid
    }
    
    func setChairUid(_chairUid: String) -> Void {
        chairUid = _chairUid
    }
    
    func setRecensori (_recensori: [String]) -> Void {
        recensori = _recensori
    }
    
    func setAutori(_autori: [String]) -> Void {
        autori = _autori
    }
    
    func addRecensore(_toAdd: String) -> Void {
        recensori.append(_toAdd)
    }
    
    func addAutore(_toAdd: String) -> Void {
        autori.append(_toAdd)
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
    
    func setScadenzaSottomissione(_scadenzaSottomissione : String) -> Void {
        scadenzaSottomissione = _scadenzaSottomissione
    }
    
    func setScadenzaReview (_scadenzaReview : String) -> Void {
        scadenzaReview = _scadenzaReview
    }
    
    func setScadenzaRivisti (_scadenzaRivisti : String) -> Void {
        scadenzaRivisti = _scadenzaRivisti
    }
    
    func getUid() -> String {
        return uid
    }
    
    func getChairUid() -> String {
        return chairUid
    }
    
    func getRecensori() -> [String] {
        return recensori
    }
    
    func getAutori() -> [String] {
        return autori
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
    
    func getScadenzaSottomissione() -> String {
        return scadenzaSottomissione
    }
    
    func getScadenzaReview() -> String {
        return scadenzaReview
    }
    
    func getscadenzaRivisti() -> String {
        return scadenzaRivisti
    }
}
