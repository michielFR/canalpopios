//
//  MyPopViewController.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import UIKit
import Charts

class MyPopViewController: UIViewController {
    
    @IBOutlet var pieViewMyPop: PieChartView!
    var zenders = [PopZender]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APIController.shared.fetchPopulaireZendersGebruiker{
            (popzenders) in
            if let popzenders = popzenders {
                self.zenders = popzenders
                self.setupPieChart()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieViewMyPop.rotationAngle = -90
        pieViewMyPop.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setupPieChart(){
        DispatchQueue.main.async {
            self.pieViewMyPop.chartDescription?.enabled = false
            self.pieViewMyPop.drawHoleEnabled = true
            self.pieViewMyPop.rotationAngle = -90
            self.pieViewMyPop.rotationEnabled = true
            self.pieViewMyPop.highlightPerTapEnabled = false
            self.pieViewMyPop.isUserInteractionEnabled = true
            self.pieViewMyPop.legend.enabled = false
            
            
            var entries : [PieChartDataEntry] = Array()
            for zender in self.zenders {
                entries.append(PieChartDataEntry(value: Double(zender.rating), label: zender.naam))
            }
            
            let dataSet = PieChartDataSet(entries: entries, label: "zenders")
            dataSet.colors = ChartColorTemplates.material()
            dataSet.drawValuesEnabled = true
            dataSet.entryLabelFont = UIFont.systemFont(ofSize: 25)
            dataSet.valueFont = UIFont.systemFont(ofSize: 18)
            
            self.pieViewMyPop.holeColor = UIColor.systemBackground
            self.pieViewMyPop.data = PieChartData(dataSet: dataSet)
            self.pieViewMyPop.animate(xAxisDuration: 1, yAxisDuration: 1)
        }
    }
}
