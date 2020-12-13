//
//  SpreadForAgeAndGenderChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    
    func makePercentedData(_ values: [Any]) -> [Double] {
        var total: Double = 0
        
        for value in values {
            if value as? Double != nil { total += value as! Double }
        }
        
        var percentedData: [Double] = []
        
        for i in 0..<values.count{
            if i >= 10 { break }
            if values[i] as? Double != nil {
                percentedData.append(((values[i] as! Double) / total ) * 100)
            }
        }
        
        return percentedData
    }
    
    func initSpreadChart(_ cell: BottomContainerCell, _ data: [[String: Any]], _ extractionOption: Options) {
        
        guard let values = extractValuesFrom(data, Constants.Keys.totalCases, extractionOption) else { return }
        
        let percentedData = makePercentedData(values)
        let spreadChart = initBasicChartView("bar", true)
        
        let crosshair = HICrosshair()
        crosshair.width = 1
        crosshair.color = HIColor(name: "gray")
        crosshair.zIndex = 5
        crosshair.dashStyle = "dash"
        
        let xAxisLeft = HIXAxis()
        xAxisLeft.categories = ["0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80-89","+90"]
        xAxisLeft.reversed = false
        xAxisLeft.crosshair = crosshair
        xAxisLeft.labels = HILabels()
            
        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.style = HICSSObject()
        yAxis.tickInterval = 10
        yAxis.labels = HILabels()
        yAxis.labels.formatter = HIFunction(jsFunction: "function () { return Math.abs(this.value); }")
        yAxis.labels.rotation = 0
        yAxis.title.text = "קבוצת גיל"
        yAxis.crosshair = crosshair
        yAxis.tickAmount = 5
        
        let male = HIBar()
        male.color = HIColor(name: "rgba(88,223,255,1)")
        male.name = "גברים"
        male.borderRadius = 5
        male.data = percentedData
        
        let female = HIBar()
        female.name = "נשים"
        female.borderRadius = 5
        female.color = HIColor(hexValue: "b6ca51" )
        female.data = percentedData.map({ (val) in
            return -val
        })
        
        let plotOptions = HIPlotOptions()
        plotOptions.bar = HIBar()
        plotOptions.bar.stacking = "normal"
        
        let tooltip = HITooltip()
        tooltip.shared = false
        
        spreadChart.options.plotOptions = plotOptions
        spreadChart.options.xAxis = [xAxisLeft]
        spreadChart.options.yAxis = [yAxis]
        spreadChart.options.series = [male, female]
        spreadChart.options.tooltip = tooltip
        spreadChart.options.legend.align = "right"
        spreadChart.options.legend.layout = "horizontal"
        spreadChart.options.legend.verticalAlign = "top"
        spreadChart.options.legend.rtl = true
            
        spreadChart.delegate = cell
        cell.chart = spreadChart
        cell.chartType = .spreadForAgeAndGender
        cell.pinView(spreadChart, UIEdgeInsets(top: cell.contentView.frame.height / 6, left: 20, bottom: 20, right: 20))
    }
    
    func updateSpreadForAgeAndGenderMode(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let bar = serie as? HIBar {
                    switch bar.name {
                    case "נשים": bar.color = HIColor(name: Constants.HIPeachDM)
                    default: bar.color = HIColor(name: Constants.HILightBlueDM)
                    }
                }
            }
            updateLabels("white", chart)
        } else {
            for serie in chart.options.series {
                if let bar = serie as? HIBar {
                    switch bar.name {
                    case "נשים": bar.color = HIColor(hexValue: Constants.HIGreenLM)
                    default: bar.color = HIColor(name: Constants.HILightBlueLM)
                    }
                }
            }
            updateLabels(Constants.HILabelDarkBlue, chart)
        }
        
        chart.updateOptions()
    }
}
