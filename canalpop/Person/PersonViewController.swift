//
//  PersonViewController.swift
//  canalpop
//
//  Created by Michiel François on 05/11/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet var gebruikersnaamLabel: UILabel!
    @IBOutlet var meldAfButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        gebruikersnaamLabel.text = UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    @IBAction func MeldAfClicked(){
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "username")
        performSegue(withIdentifier: "MeldAf", sender: self)
    }
}
