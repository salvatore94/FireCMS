//
//  RecensoreInfoViewController.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 13/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit

class RecensoreInfoViewController: UIViewController {

    @IBOutlet weak var nomeLabel: CustomPaddedLabel!
    
    @IBOutlet weak var emailLabel: CustomPaddedLabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    var nome : String?
    var email : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nomeLabel.text = nome
        emailLabel.text = email
        
        
    }
    
    public func setNomeLabel(_nome: String) -> Void {
        nome = _nome
    }
    
    public func setEmailLabel(_email: String) -> Void {
        email = _email
    }
    
    @IBAction func chiudi(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
