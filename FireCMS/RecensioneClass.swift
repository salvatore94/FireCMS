//
//  RecensioneClass.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 05/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import Foundation

class RecensioneClass {
    private var uid: String
    private var recensoreUid : String
    private var articoloUid : String
    private var voto : Double
    private var commento : String
    private var commentoPrivato: String
    
    init() {
        uid = ""
        recensoreUid = ""
        articoloUid = ""
        voto = 0
        commento = ""
        commentoPrivato = ""
    }
    
    init (_uid: String, _recensoreUid: String, _articoloUid: String, _voto: Double, _commento: String) {
        uid = _uid
        recensoreUid = _recensoreUid
        articoloUid = _articoloUid
        voto = _voto
        commento = _commento
        commentoPrivato = ""
    }
    
    init (_uid: String, _recensoreUid: String, _articoloUid: String, _voto: Double, _commento: String, _commentoPrivato: String) {
        uid = _uid
        recensoreUid = _recensoreUid
        articoloUid = _articoloUid
        voto = _voto
        commento = _commento
        commentoPrivato = _commentoPrivato
    }
    
    func setUid(_uid: String) -> Void {
        uid = _uid
    }
    
    func setRecensoreUid(_recensoreUid: String) -> Void {
        recensoreUid = _recensoreUid
    }
    
    func setArtioloUidUid(_articoloUid: String) -> Void {
        articoloUid = _articoloUid
    }
    
    func setVoto(_voto: Double) -> Void {
        voto = _voto
    }
    
    func setCommento(_commento: String) -> Void {
        commento = _commento
    }
    
    func setCommentoPrivato(_commentoPrivato: String) -> Void {
        commentoPrivato = _commentoPrivato
    }
    
    func getUid() -> String {
        return uid
    }
    
    func getRecensoreUid() -> String {
        return recensoreUid
    }
    
    func getArticoloUid() -> String {
        return articoloUid
    }
    
    func getVoto() -> Double {
        return voto
    }
    
    func getCommento() -> String {
        return commento
    }
    
    func getCommentoPrivato() -> String {
        return commentoPrivato
    }
}
