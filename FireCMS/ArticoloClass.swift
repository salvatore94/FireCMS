//
//  ArticoloClass.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 04/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import Foundation

class ArticoloClass {
    private var uid : String
    private var autoreUid : String
    private var titolo : String
    private var tema : String
    
    public init () {
        uid = ""
        autoreUid = ""
        titolo = ""
        tema = ""
    }
    
    public init (_uid: String, _autoreUid: String, _titolo: String, _tema: String) {
        uid = _uid
        autoreUid = _autoreUid
        titolo = _titolo
        tema = _tema
    }
    
    public func setUid (_uid: String) -> Void {
        uid = _uid
    }
    
    public func setAutoreUid(_autoreUid: String) -> Void {
        autoreUid = _autoreUid
    }
    
    public func setTitolo(_titolo: String) -> Void {
        titolo = _titolo
    }
    
    public func setTema(_tema: String) -> Void {
        tema = _tema
    }
    
    public func getUid() -> String {
        return uid
    }
    
    public func getAutoreUid() -> String {
        return autoreUid
    }
    
    public func getTitolo() -> String {
        return titolo
    }
    
    public func getTema() -> String {
        return tema
    }
}
