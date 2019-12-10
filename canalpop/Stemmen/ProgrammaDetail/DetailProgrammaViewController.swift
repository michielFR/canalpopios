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
        if programma.rating < 5{
            programma.rating += 1
            APIController.shared.rateProgramma(id: programma.id, rating: programma.rating){
                (ratingDTO) in
                if let ratingDTO = ratingDTO {
                    print(ratingDTO)
                    DispatchQueue.main.async {self.refreshWaardes()}
                }
            }
        } else {
            let alert = UIAlertController(title: "Opgelet", message: "Ratings gaan van -5 tot 5", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Oké", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func DownButtonClicked(){
        if programma.rating > -5{
            programma.rating -= 1
            APIController.shared.rateProgramma(id: programma.id, rating: programma.rating){
                (ratingDTO) in
                if let ratingDTO = ratingDTO {
                    print(ratingDTO)
                    DispatchQueue.main.async {self.refreshWaardes()}
                }
            }
        }else {
            let alert = UIAlertController(title: "Opgelet", message: "Ratings gaan van -5 tot 5", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Oké", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIController.shared.fetchProgrammaRatingGebruiker(programma.id){
            (ratings) in
            if let ratings = ratings {
                print(ratings)
                for rating in ratings {
                    self.programma.rating = rating.rating
                }
                DispatchQueue.main.async {self.refreshWaardes()}
            }
        }
        self.title = programma.naam
    }
    
    func refreshWaardes(){
        progNaam.text = programma.naam
        progType.text = programma.type
        progOmschrijving.text = programma.omschrijving
        progRating.text = String(programma.rating)
    }
}
