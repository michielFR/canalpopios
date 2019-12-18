//
//  DetailProgrammaViewController.swift
//  canalpop
//
//  Created by Michiel François on 05/11/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class DetailProgrammaViewController: UIViewController {

    var programma: Programma!
    
    @IBOutlet var progNaam: UILabel!
    @IBOutlet var progType: UILabel!
    @IBOutlet var progOmschrijving: UITextView!
    @IBOutlet var progRating: UILabel!
    @IBOutlet var upButton: UIImageView!
    @IBOutlet var downButton: UIImageView!
    
    @IBAction func UpButtonClicked(){
        if(Reachability.isConnected()){
            if programma.rating < 5{
                programma.rating += 1
                APIService.shared.rateProgramma(id: programma.id, rating: programma.rating){
                    (ratingDTO) in
                    if let ratingDTO = ratingDTO {
                        print(ratingDTO)
                        DispatchQueue.main.async {self.refreshWaardes()}
                    }
                }
            } else {
                showAlert(message: "Ratings gaan van -5 tot 5")
            }
        } else {
            showAlert(message: "U bent niet verbonden met internet, stemmen is nu niet mogelijk")
        }
        
    }
    
    @IBAction func DownButtonClicked(){
        if(Reachability.isConnected()){
            if programma.rating > -5{
                programma.rating -= 1
                APIService.shared.rateProgramma(id: programma.id, rating: programma.rating){
                    (ratingDTO) in
                    if let ratingDTO = ratingDTO {
                        print(ratingDTO)
                        DispatchQueue.main.async {self.refreshWaardes()}
                    }
                }
            }else {
                showAlert(message: "Ratings gaan van -5 tot 5")
            }
        } else {
            showAlert(message: "U bent niet verbonden met internet, stemmen is nu niet mogelijk")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.shared.fetchProgrammaRatingGebruiker(programma.id){
            (ratings) in
            if let ratings = ratings {
                print(ratings)
                for rating in ratings {
                    self.programma.rating = rating.rating
                }
                DispatchQueue.main.async {self.refreshWaardes()}
            }
            DispatchQueue.main.async {self.refreshWaardes()}
        }
        self.title = programma.naam
    }
    
    func refreshWaardes(){
        progNaam.text = programma.naam
        progType.text = programma.type
        progOmschrijving.text = programma.omschrijving
        progRating.text = String(programma.rating)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Opgelet", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Oké", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
