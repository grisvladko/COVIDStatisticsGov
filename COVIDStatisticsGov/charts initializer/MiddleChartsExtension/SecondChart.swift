//
//  SecondChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    func initSecondChart(_ cell: MiddleContainerCell, _ data: [[String: Any]]) {
    
        guard let values = extractValuesFrom(data, Constants.Keys.severe, .week) else { return }
        guard let dates = getDates(data, .week) else { return }
        
        let secondHi = initBasicChartView("line", false )
        secondHi.isUserInteractionEnabled = false
        
        let xAxis = HIXAxis()
        xAxis.min = 0
        xAxis.categories = dates as? [String]
        xAxis.labels = HILabels()
        xAxis.labels.rotation = 0
        secondHi.options.xAxis = [xAxis]
        
        let yAxis = HIYAxis()
        yAxis.gridLineWidth = 0
        yAxis.title = HITitle()
        yAxis.labels = HILabels()
        yAxis.title.text = ""
        secondHi.options.yAxis = [yAxis]
        
        let area = HIArea()
        let gradient = HIColor(linearGradient: ["x1": 0, "x2": 0, "y1": 0, "y2": 1.2], stops: [[0,"rgba(30,137,138,1)"],[1,"rgba(255, 255, 255, 0.0)"]])
        area.color = gradient
        area.data = values
        area.marker = HIMarker()
        area.marker.enabled = true
        area.marker.fillColor = HIColor(uiColor: .white)
        area.marker.radius = 3
        area.marker.lineWidth = 2
        area.marker.lineColor = "rgba(30,137,138,1)"
        
        let dataLabels = HIDataLabels()
        dataLabels.enabled = true
        dataLabels.style = HICSSObject()
        dataLabels.style.fontWeight = "none"
        dataLabels.color = HIColor(uiColor: Constants.darkBlueLM)
        
        area.dataLabels = [dataLabels]
        
        secondHi.options.series = [area]
        secondHi.options.tooltip = HITooltip()
        secondHi.options.tooltip.enabled = false
        
        secondHi.delegate = cell
        cell.chart = secondHi
        cell.chartType = .second
        cell.contentView.pinView(secondHi, UIEdgeInsets(top: cell.contentView.frame.height / 3.5, left: 20, bottom: 20, right: 20))
    }
    
    func updateSecond(_ chart: HIChartView,_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 1],Constants.HIGreenDM, area)
                    area.marker.lineColor = Constants.HIGreenDM
                }
            }
            updateLabels("white", chart)
        } else {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 1],Constants.HIDeemBlueLM, area)
                    area.marker.lineColor = Constants.HIDeemBlueLM
                }
            }
            updateLabels(Constants.HILabelDarkBlue, chart)
        }
        chart.updateOptions()
    }
}
