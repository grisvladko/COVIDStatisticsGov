//
//  HeavilySickChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    
    func initHeavilySickChart(_ cell: BottomContainerCell, _ data: [[String: Any]], _ extractionOption: Options) {
        
        guard let realDates = getRealDates(data, extractionOption) else { return }
        let heavilySick = initBasicChartView("line", true)
        
        let filterValues = makeFilterValues(realDates)
        
        var realData: [Any] = []
        var c = 0
        for date in realDates {
            c += 1
            realData.append([date, c])
        }
        heavilySick.isUserInteractionEnabled = false
        
        let xAxis = HIXAxis()
        xAxis.type = "datetime"
        xAxis.tickAmount = 5
        xAxis.tickInterval = 7 * 24 * 3600 * 1000 as NSNumber // set
        xAxis.dateTimeLabelFormats = HIDateTimeLabelFormats()
        xAxis.dateTimeLabelFormats.day = HIDay()
        xAxis.dateTimeLabelFormats.day.main = "%e. %m"
        xAxis.title = HITitle()
        xAxis.title.style = HICSSObject()
        xAxis.labels = HILabels()
        xAxis.labels.rotation = 0
        xAxis.title.text = "תאריך"
            
        let yAxis = HIYAxis()
        yAxis.title = HITitle()
        yAxis.title.style = HICSSObject()
        yAxis.labels = HILabels()
        yAxis.title.text = "מספר מקרים"
        yAxis.min = 0
        
        let plotOptions = HIPlotOptions()
        plotOptions.line = HILine()
        plotOptions.line.marker = HIMarker()
        plotOptions.line.marker.symbol = "none"
        
        let line1 = HILine()
        line1.name = "חולים קשה"
        line1.data = realData
        line1.color = HIColor(hexValue: "b6ca51")
        let dataLabels = makeDataLabels(filterValues, line1.color)
        line1.dataLabels = dataLabels
        
        let line2 = HILine()
        line2.name = "מונשמים"
        line2.data = realData
        line2.color = HIColor(name: "rgba(88,223,255,1)")
        let dataLabels2 = makeDataLabels(filterValues, line2.color)
        line2.dataLabels = dataLabels2
        
        let line3 = HILine()
        line3.name = "נפטרים"
        line3.data = realData
        line3.color = HIColor(rgb: 30, green: 137, blue: 138)
        let dataLabels3 = makeDataLabels(filterValues, line3.color)
        line3.dataLabels = dataLabels3
        
        heavilySick.options.xAxis = [xAxis]
        heavilySick.options.yAxis = [yAxis]
        heavilySick.options.plotOptions = plotOptions
        heavilySick.options.series = [line1,line2,line3]
        heavilySick.options.legend.align = "right"
        heavilySick.options.legend.layout = "horizontal"
        heavilySick.options.legend.verticalAlign = "top"
        heavilySick.options.legend.rtl = true
            
        heavilySick.delegate = cell
        cell.chart = heavilySick
        cell.chartType = .heavilySick
        cell.pinView(heavilySick, UIEdgeInsets(top: cell.contentView.frame.height / 5, left: 20, bottom: 20, right: 20))
    }
    
    func makeFilterValues(_ data: [Any]) -> [NSNumber]{
        let count = (data.count - 1) / 4
        
        var filterValues: [NSNumber] = []
        
        for i in 0..<4 {
            let j = count * i
            if j < 0 || j >= data.count { break }
            guard let number = data[j] as? NSNumber else { break }
            filterValues.append(number)
        }
        
        return filterValues
    }
    
    func makeDataLabels(_ filterValues: [NSNumber], _ borderColor: HIColor) -> [HIDataLabels] {
        var result: [HIDataLabels] = []
        
        for i in 0..<filterValues.count {
            let dataLabels = HIDataLabels()
            dataLabels.filter = HIFilter()
            dataLabels.filter.value = filterValues[i]
            dataLabels.filter.property = "x"
            dataLabels.filter.operator = "==="
            dataLabels.enabled = true
            dataLabels.y = 10
            dataLabels.allowOverlap =  true
            dataLabels.backgroundColor = "white"
            dataLabels.borderColor = borderColor
            dataLabels.borderWidth = 3
            dataLabels.borderRadius = 5
            
            result.append(dataLabels)
        }
        
        return result
    }
    
    func updateHeavilySickMode(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            updateLabels("white", chart)
            for serie in chart.options.series {
                if let line = serie as? HILine {
                    switch line.name {
                    case "מונשמים": line.color = HIColor(name: Constants.HILightBlueDM)
                    case "חולים קשה": line.color = HIColor(name: Constants.HIPeachDM)
                    default: line.color = HIColor(name: Constants.HIGreenDM)
                    }
                    updateDataLabels(line.dataLabels, line.color)
                }
            }
        } else {
            updateLabels(Constants.HILabelDarkBlue, chart)
            for serie in chart.options.series {
                if let line = serie as? HILine {
                    switch line.name {
                    case "מונשמים": line.color = HIColor(name: Constants.HILightBlueLM)
                        
                    case "חולים קשה": line.color = HIColor(hexValue: Constants.HIGreenLM)
                    default: line.color = HIColor(name: Constants.HIDeemBlueLM)
                    }
                    updateDataLabels(line.dataLabels, line.color)
                }
            }
        }
        
        chart.updateOptions()
    }
    
    func updateDataLabels(_ dataLabels: [HIDataLabels], _ color: HIColor) {
        for dataLabel in dataLabels {
            dataLabel.borderColor = color
        }
    }
}
