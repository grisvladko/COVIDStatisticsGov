//
//  MiddleChartsInitExtension.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
        
    func initThirdChart(_ cell: MiddleContainerCell,_ data: [[String: Any]]) {
        
        guard let values = extractValuesFrom(data, Constants.Keys.severe, .week) else { return }
        guard let dates = getDates(data, .week) else { return }
        
        let thirdHi = initBasicChartView("column", false)
        
        let xAxis = HIXAxis()
        xAxis.min = 0
        xAxis.categories = dates as? [String]
        xAxis.labels = HILabels()
        xAxis.labels.rotation = 0
        
        let yAxis = HIYAxis()
        yAxis.min = 0
        yAxis.gridLineWidth = 0
        yAxis.title = HITitle()
        yAxis.labels = HILabels()
        yAxis.title.text = ""
        
        let plotLines = HIPlotLines()
        plotLines.color = HIColor(name: "red")
        plotLines.value = 100
        plotLines.width = 1
        plotLines.zIndex = 10
        plotLines.dashStyle = "dash"
        plotLines.label = HILabel()
        plotLines.label.align = "left"
        plotLines.label.x = -25
        plotLines.label.y = 5
        plotLines.label.textAlign = "center"
        plotLines.label.useHTML = true
        plotLines.label.enabled = true
        plotLines.label.text = "100"
        plotLines.label.style = HICSSObject()
        plotLines.label.style.backgroundColor = "red"
        plotLines.label.style.color = "white"
        yAxis.plotLines = [plotLines]
        
        let column = HIColumn()
        column.data = values
        column.borderRadius = 5
        column.pointWidth = 10
        column.color = HIColor(hexValue: "b6ca51")
        
        thirdHi.options.xAxis = [xAxis]
        thirdHi.options.yAxis = [yAxis]
        thirdHi.options.series = [column]
        thirdHi.options.tooltip = HITooltip()
        thirdHi.options.tooltip.enabled = false
        
        thirdHi.delegate = cell
        cell.chart = thirdHi
        cell.chartType = .third
        cell.contentView.pinView(thirdHi, UIEdgeInsets(top: cell.contentView.frame.height / 3.2, left: 20, bottom: 20, right: 20))
    }
    
    func updateThird(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let column = serie as? HIColumn {
                    column.color = HIColor(name: Constants.HIPeachDM)
                }
            }
            updateLabels("white", chart)
        } else {
            for serie in chart.options.series {
                if let column = serie as? HIColumn {
                    column.color = HIColor(hexValue: Constants.HIGreenLM)
                }
            }
            updateLabels(Constants.HILabelDarkBlue, chart)
        }
        chart.updateOptions()
    }
}
