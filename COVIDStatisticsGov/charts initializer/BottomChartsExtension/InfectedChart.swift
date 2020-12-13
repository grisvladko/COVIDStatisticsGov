//
//  InfectedChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    func initInfectedExamChart(_ cell: BottomContainerCell, _ data: [[String: Any]]) {
        
        let infectedChart = initBasicChartView("column", true)
        
        let xAxis = HIXAxis()
        xAxis.labels = HILabels()
        xAxis.title = HITitle()
        xAxis.title.text = "תאריך הבדיקה"
        xAxis.title.style = HICSSObject()
        xAxis.categories = ["1","2","3","4","5","6"]
        
        let yAxis = HIYAxis()
        yAxis.labels = HILabels()
        yAxis.title = HITitle()
        yAxis.title.text = "מספר בדיקות"
        yAxis.title.style = HICSSObject()
        yAxis.min = 0
        
        let plotOptions = HIPlotOptions()
        plotOptions.column = HIColumn()
        plotOptions.column.grouping = false
        
        let column1 = HIColumn()
        column1.name = "בדיקות"
        column1.data = [1,2,3,4,5,6]
        column1.pointPlacement = 0
        column1.color = HIColor(name: "rgba(88,223,255,1)")
        column1.pointWidth = 6
        column1.borderRadius = 3
        
        let column2 = HIColumn()
        column2.name = "מאומתים"
        column2.data = [0.2,0.2,0.2,0.2,0.2,0.2]
        column2.color = HIColor(rgb: 30, green: 137, blue: 138)
        column2.pointPlacement = 0
        let dataLabels = HIDataLabels()
        dataLabels.enabled = true
        dataLabels.backgroundColor = "white"
        dataLabels.color = HIColor(rgb: 30, green: 137, blue: 138)
        dataLabels.borderColor = HIColor(rgb: 30, green: 137, blue: 138)
        dataLabels.y = 5
        dataLabels.borderWidth = 3
        dataLabels.borderRadius = 5
        column2.dataLabels = [dataLabels]
        column2.pointWidth = 6
        
        infectedChart.options.tooltip = HITooltip()
        infectedChart.options.tooltip.shared = true
        infectedChart.options.plotOptions = plotOptions
        infectedChart.options.xAxis = [xAxis]
        infectedChart.options.yAxis = [yAxis]
        infectedChart.options.series = [column1, column2]
        infectedChart.options.legend.align = "right"
        infectedChart.options.legend.layout = "horizontal"
        infectedChart.options.legend.verticalAlign = "top"
        infectedChart.options.legend.rtl = true
                  
        infectedChart.delegate = cell
        cell.chart = infectedChart
        cell.chartType = .infected
        cell.pinView(infectedChart, UIEdgeInsets(top: cell.contentView.frame.height / 5, left: 20, bottom: 20, right: 20))
    }

    func updateInfectedMode(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            updateLabels("white", chart)
            for serie in chart.options.series {
                if let column = serie as? HIColumn {
                    switch column.name {
                    case "בדיקות": column.color = HIColor(name: Constants.HILightBlueDM)
                    default: column.color = HIColor(name: Constants.HIPeachDM)
                        updateDataLabels(column.dataLabels, column.color)
                    }
                }
            }
        } else {
            updateLabels(Constants.HILabelDarkBlue, chart)
            for serie in chart.options.series {
                if let column = serie as? HIColumn {
                    switch column.name {
                    case "בדיקות": column.color = HIColor(name: Constants.HILightBlueLM)
                    default: column.color = HIColor(name: Constants.HIDeemBlueLM)
                        updateDataLabels(column.dataLabels, column.color)
                    }
                }
            }
        }
        chart.updateOptions()
    }
}
