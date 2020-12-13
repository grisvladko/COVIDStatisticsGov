//
//  FirstChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    func initFirstChart(_ cell: MiddleContainerCell,_ data: [[String: Any]]) {
            
        guard let values = extractValuesFrom(data, Constants.Keys.severe, .week) else { return }
        guard let dates = getDates(data, .week) else { return }
        
        var total: Double = 0
        
        for value in values {
            if value as? Double != nil { total += value as! Double }
        }
        
        var percentedData: [Double] = []
        
        for value in values {
            if value as? Double != nil {
                percentedData.append(((value as! Double) / total ) * 100)
            }
        }
        
        let firstHi = initBasicChartView("line", false)
        firstHi.isUserInteractionEnabled = false
        let xAxis = HIXAxis()
        xAxis.min = 0
        xAxis.categories = dates as? [String]
        xAxis.labels = HILabels()
        xAxis.labels.rotation = 0
        firstHi.options.xAxis = [xAxis]
                
        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.style = HICSSObject()
        yAxis.title.style.fontSize = "17"
        yAxis.title.text = "אחוז שינוי יומי"
        yAxis.labels = HILabels()
        yAxis.labels.enabled = true
        yAxis.labels.format = "{value}%"
        yAxis.gridLineWidth = 0
        firstHi.options.yAxis = [yAxis]
                
        let area = HIArea()
        let gradient = HIColor(linearGradient: ["x1": 0, "x2": 0, "y1": 0, "y2": 2], stops: [[0,"rgba(88,223,255,0.6)"],[1,"rgba(255, 255, 255, 0.0)"]])
        area.color = gradient
        area.data = percentedData
        area.marker = HIMarker()
        area.marker.enabled = true
        area.marker.fillColor = HIColor(uiColor: .white)
        area.marker.radius = 3
        area.marker.lineWidth = 2
        area.marker.lineColor = "rgba(88,223,255,1)"
        
        let dataLabels = HIDataLabels()
        dataLabels.enabled = true
        
        dataLabels.format = "{point.y: .0f}%"
        dataLabels.color = HIColor(uiColor: Constants.darkBlueLM)
        
        area.dataLabels = [dataLabels]
        
        firstHi.options.series = [area]
        firstHi.options.legend = HILegend()
        firstHi.options.legend.enabled = false
        firstHi.options.tooltip = HITooltip()
        firstHi.options.tooltip.enabled = false

        firstHi.delegate = cell
        cell.chart = firstHi
        cell.chartType = .first
        cell.contentView.pinView(firstHi, UIEdgeInsets(top: cell.contentView.frame.height / 4, left: 20, bottom: 20, right: 20))
    }
    
    func updateFirst(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 2],Constants.HILightBlueDM, area)
                }
            }
            updateLabels("white", chart)
        } else {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 2], Constants.HILightBlueLM, area)
                }
            }
            updateLabels(Constants.HILabelDarkBlue, chart)
        }
        
        chart.updateOptions()
    }
}
