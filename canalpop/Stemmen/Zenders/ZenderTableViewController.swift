//
//  ZenderTableViewController.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit

class ZenderTableViewController: UITableViewController {
    var zenders = [Zender]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CanalPopController.shared.fetchZenders { (zenders) in
            self.zenders = zenders
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zenders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // stap 1: dequeue the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZenderCell", for: indexPath) as! ZenderTableViewCell
        
        // stap 2: fetch model object to display.
        let zender = zenders[indexPath.row]
        
        // Configure the cell
        cell.update(with: zender)

        // stap 4: return de cell.
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowProgrammas", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProgrammaTableViewController {
            destination.zender = zenders[(tableView.indexPathForSelectedRow!.row)]
        }
    }
}
