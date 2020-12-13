//
//  BottomChartsModeUpdateExtension.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit




//--------------- Bottom Container Charts Mode Update ----------------//



extension ChartsInitializer {
    func updateChartModeForBottomContainer(_ chart: HIChartView, _ type: BottomContainerCell.CellChartType, _ isDarkModeOn: Bool)  {
        switch type {
            case .epidemicCurve: updateEpidemicCurveMode(chart, isDarkModeOn)
            case .heavilySick: updateHeavilySickMode(chart, isDarkModeOn)
            case .spreadForAgeAndGender: updateSpreadForAgeAndGenderMode(chart, isDarkModeOn)
            case .pie: updatePieMode(chart, isDarkModeOn)
            case .infected: updateInfectedMode(chart, isDarkModeOn)
        }
    }
}



//--------------- Bottom Container Charts Data Update ----------------//



extension ChartsInitializer {
    func updateChart(_ chart: HIChartView, _ type: BottomContainerCell.CellChartType, _ option: ChartsInitializer.Options, _ data: [[String: Any]]) {
        switch type {
            case .epidemicCurve: updateEpidemicCurveData(chart, option, data)
            case .heavilySick: updateHeavilySickData(chart, option, data)
            case .spreadForAgeAndGender: updateSpreadForAgeAndGenderData(chart, option, data)
            default: break
        }
    }
    
    func updateEpidemicCurveData(_ chart: HIChartView, _ option: ChartsInitializer.Options, _ data: [[String: Any]]) {
        
        guard let values = extractValuesFrom(data, Constants.Keys.totalCases, option) else { return }
        guard let dates = getDates(data, option) else { return }
        
        for serie in chart.options.series {
            serie.data = values.shuffled()
        }
        
        for xAxis in chart.options.xAxis {
            xAxis.categories = dates as? [String]
            xAxis.labels.rotation = 0
        }
        
        chart.updateOptions()
    }
    
    func updateSpreadForAgeAndGenderData(_ chart: HIChartView, _ option: ChartsInitializer.Options, _ data: [[String: Any]]) {
        
        guard let values = extractValuesFrom(data, Constants.Keys.totalCases, option) else { return }
        let percentedData = makePercentedData(values)
        
        for serie in chart.options.series {
            if serie.name == "גברים" {
                serie.data = percentedData
            }
            if serie.name == "נשים" {
                serie.data = percentedData.map({ (val) -> Double in
                    return -val
                })
            }
        }
        
        for yAxis in chart.options.yAxis {
            yAxis.labels.rotation = 0
        }
        
        chart.updateOptions()
    }
    
    func updateHeavilySickData(_ chart: HIChartView, _ option: ChartsInitializer.Options, _ data: [[String: Any]]) {
        guard let values = extractValuesFrom(data, Constants.Keys.totalCases, option) else { return }
        guard let dates = getRealDates(data, option) else { return }
        
        var realData: [Any] = []
        
        for i in 0..<dates.count {
            if i >= values.count { break }
            realData.append([dates[i], values[i]])
        }
        
        for serie in chart.options.series {
            serie.data = realData
            let filterValues = makeFilterValues(dates)
            let dataLabels = makeDataLabels(filterValues, serie.color)
            serie.dataLabels = dataLabels
        }
        
        chart.updateOptions()
    }
}
