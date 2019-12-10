//
//  ProgrammaTableViewController.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class ProgrammaTableViewController: UITableViewController {
    
    var zender : Zender!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        self.title = zender.naam
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (zender?.programmas.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // stap 1: dequeue the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammaCell", for: indexPath) as! ProgrammaTableViewCell
        
        // stap 2: fetch model object to display.
        let programma = zender?.programmas[indexPath.row]
        
        // Configure the cell
        cell.update(with: programma!)

        // stap 4: return de cell.
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProgrammaDetail", sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailProgrammaViewController {
            destination.programma = zender.programmas[(tableView.indexPathForSelectedRow!.row)]
        }
    }
}
