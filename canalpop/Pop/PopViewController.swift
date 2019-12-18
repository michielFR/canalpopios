//
//  PopViewController.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit
import Charts

class PopViewController: UIViewController {

    @IBOutlet var pieViewPop: PieChartView!
    var zenders = [PopZender]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CanalPopController.shared.fetchPopulaireZenders { (popzenders) in
            self.zenders = popzenders
            self.setupPieChart()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieViewPop.rotationAngle = -90
        pieViewPop.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setupPieChart(){
        DispatchQueue.main.async {
            self.pieViewPop.chartDescription?.enabled = false
            self.pieViewPop.drawHoleEnabled = true
            self.pieViewPop.rotationAngle = -90
            self.pieViewPop.rotationEnabled = true
            self.pieViewPop.highlightPerTapEnabled = false
            self.pieViewPop.isUserInteractionEnabled = true
            self.pieViewPop.legend.enabled = false
            
            var entries : [PieChartDataEntry] = Array()
            for zender in self.zenders {
                entries.append(PieChartDataEntry(value: Double(zender.rating), label: zender.naam))
            }
            
            let dataSet = PieChartDataSet(entries: entries, label: "zenders")
            dataSet.colors = ChartColorTemplates.material()
            dataSet.drawValuesEnabled = true
            dataSet.entryLabelFont = UIFont.systemFont(ofSize: 25)
            dataSet.valueFont = UIFont.systemFont(ofSize: 18)
            
            self.pieViewPop.holeColor = UIColor.systemBackground
            self.pieViewPop.data = PieChartData(dataSet: dataSet)
            self.pieViewPop.animate(xAxisDuration: 1, yAxisDuration: 1)
        }
    }
}
