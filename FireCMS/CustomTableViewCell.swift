//
//  CustomTableViewCell.swift
//  FireCMS
//
//  Created by Salvatore  Polito on 02/04/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var cellLabel: CustomPaddedLabel!

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
