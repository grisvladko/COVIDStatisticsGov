//
//  StuffPieChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    func initHealthStuffChart(_ cell: BottomContainerCell, _ data: [[String: Any]]) {
        let stuffChart = initBasicChartView("pie", false)
            
        let data = [30,20,10]
        var total = 0
        for i in data {
            total += i
        }
        
        let pie = HIPie()
        pie.colors = [HIColor(name: "rgba(88,223,255,1)"),
                      HIColor(hexValue: "b6ca51"),
                      HIColor(rgb: 30, green: 137, blue: 138)]
        pie.innerSize = "75%"
        pie.size = "60%"
        pie.data = [["name": "רופאים/ות", "y": data[0], "states": "select: { color: 'rgba(88,223,255,1)' }"], ["name":"אחים/ות", "y": data[1]], ["name":"מקצועות אחרים","y": data[2]]]
        let dataLabels = HIDataLabels()
        dataLabels.crop = false
        dataLabels.overflow = "none"
        dataLabels.formatter = HIFunction(jsFunction: "function () { return '<b>' + this.point.name + '</b> \n' + this.y}")
        pie.dataLabels = [dataLabels]
        pie.states = HIStates()
        
        stuffChart.options.series = [pie]
        let title = HITitle()
        title.text = "\(total) <br> סה״כ"
        title.floating = true
        title.verticalAlign = "middle"
        stuffChart.options.title = title
            
        stuffChart.options.tooltip = HITooltip()
        stuffChart.options.tooltip.enabled = false 
        stuffChart.delegate = cell
        cell.chart = stuffChart
        cell.chartType = .pie
        cell.pinView(stuffChart, UIEdgeInsets(top: cell.contentView.frame.height / 6, left: 20, bottom: 20, right: 20))
    }
    
    func updatePieMode(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let pie = serie as? HIPie {
                    pie.colors = [HIColor(name: Constants.HILightBlueLM),
                                  HIColor(name: Constants.HIPeachDM),
                                  HIColor(name: Constants.HIGreenDM)]
                }
            }
            updateLabels("white", chart)
        } else {
            for serie in chart.options.series {
                if let pie = serie as? HIPie {
                    pie.colors = [HIColor(name: Constants.HILightBlueLM),
                                  HIColor(hexValue: Constants.HIGreenLM),
                                  HIColor(name: Constants.HIDeemBlueLM)]
                }
            }
            updateLabels(Constants.HILabelDarkBlue, chart)
        }
        
        chart.updateOptions()
    }
}
