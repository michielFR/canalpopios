//
//  LoginViewController.swift
//  canalpop
//
//  Created by Michiel François on 05/11/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var gebruikersnaamTextField: UITextField!
    @IBOutlet var wachtwoordTextField: UITextField!
    @IBOutlet var meldAanButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func MeldAanClicked(){
        
        APIService.shared.login(Login(username: gebruikersnaamTextField.text!, password: wachtwoordTextField.text!)){
            (statusCode) in
            if statusCode != nil && statusCode != 400 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "MeldAan", sender: self)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Opgelet", message: "De gegevens zijn niet correct", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Sluit", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    self.gebruikersnaamTextField.text = ""
                    self.wachtwoordTextField.text = ""
                }
            }
        }
    }
}
