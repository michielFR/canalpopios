//
//  ZenderTableViewCell.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class ZenderTableViewCell: UITableViewCell {

    @IBOutlet var naamLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with zender: Zender){
        naamLabel.text = zender.naam
    }
}
