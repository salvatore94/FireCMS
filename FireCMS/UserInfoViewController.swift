//
//  UserInfoViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 27/03/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chiudiButton: UIButton!
    
    var nome : String?
    var email : String?
    var close = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if nome != nil {} else {
            self.nome = utente.getNome() + " " + utente.getCognome()
        
        }
        if email != nil {} else {
            self.email = utente.getEmail()
        }
        
        nomeLabel.text = nome
        emailLabel.text = email
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func setNomeLabel(_nome: String) -> Void {
        nome = _nome
    }
    
    public func setEmailLabel(_email: String) -> Void {
        email = _email
    }

    public func enableChiudi() -> Void {
        close = true
    }
    
    @IBAction func chiudiAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
}
