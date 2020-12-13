//
//  ChartsInitializer.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import UIKit
import Highcharts



//--------------- All Charts initialization happens here ----------------//



//--------------- Main functions and utilities ----------------//



class ChartsInitializer {
    
    enum Options {
        //timeLine
        case week
        case biWeek
        case month
        case all
    
        //situation
        case deprecated //dead
        case respiratory
        case heavilySick
        case confirmed
    }
    
    static let functions = ChartsInitializer()
    
    func initBasicChartView(_ type: String, _ isLegendEnabled: NSNumber) -> HIChartView {
        
        let chartView = HIChartView()
        let options = HIOptions()
        let chart = HIChart()
        let title = HITitle()
        title.text = ""
        
        chart.type = type
        options.chart = chart
        options.exporting = HIExporting()
        options.exporting.enabled = false
        options.title = title
        options.legend = HILegend()
        options.legend.enabled = isLegendEnabled
        chart.backgroundColor = HIColor(name: "rgba(0,0,0,0)")
        chartView.options = options
        chartView.backgroundColor = .clear
        
        return chartView
    }
    
    func setStopperForExtraction(_ option: Options) -> Int? {
        switch option {
        case .all: return nil
        case .biWeek: return 14
        case .month: return 30
        case .week: return 7
        case .confirmed: return 14
        case .deprecated: return 30
        case .heavilySick: return 7
        case .respiratory: return nil
        }
    }
    
    func extractValuesFrom(_ data: [[String: Any]], _ key: String, _ extractionOption: Options) -> [Any]? {
        var values: [Any] = []
        
        let stopper = setStopperForExtraction(extractionOption)
        
        for dict in data {
            if stopper != nil { if values.count > stopper! { break } }
            
            if let val = dict[key] {
                values.append(val)
            }
        }
        
        if values.isEmpty { return nil }
    
        return values
    }
    
    func getDates(_ data: [[String: Any]],_ extractionOption: Options) -> [Any]? {
        guard let dates = extractValuesFrom(data, Constants.Keys.date,extractionOption) else { return nil }
        return dates.map({ (date) -> Any in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/mm/yyyy"
            guard let result = formatter.date(from: date as! String) else { return ""}
            let day = Calendar.current.component(.day, from: result)
            let month = Calendar.current.component(.month, from: result)
            return "\(day).\(month)"
        })
    }
    
    func getRealDates(_ data: [[String: Any]],_ extractionOption: Options) -> [Any]? {
        guard let dates = extractValuesFrom(data, Constants.Keys.date,extractionOption) else { return nil }
        return dates.map({ (date) -> Any in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/mm/yyyy"
            guard let result = formatter.date(from: date as! String) else { return ""}
            print(result)
            let s = result.timeIntervalSince1970
            print(NSNumber(value: s * 1000))
            return NSNumber(value: s * 1000)
        })
    }
    
    func updateLabels(_ colorName: String, _ chart: HIChartView) {
        for serie in chart.options.series {
            if serie.dataLabels == nil { break }
            for dataLabels in serie.dataLabels {
                dataLabels.color = HIColor(name: colorName)
                dataLabels.borderColor = HIColor(name: colorName)
            }
        }
        if chart.options.xAxis != nil {
            for xAxis in chart.options.xAxis {
                if xAxis.labels == nil { continue }
                xAxis.labels.style = HICSSObject()
                xAxis.labels.style.color = colorName
                if xAxis.title != nil {
                    if xAxis.title.style != nil {
                        xAxis.title.style.color = colorName
                    }
                }
            }
        }
        
        if chart.options.yAxis != nil {
            for yAxis in chart.options.yAxis {
                if yAxis.labels == nil { continue }
                yAxis.labels.style = HICSSObject()
                yAxis.labels.style.color = colorName
                if yAxis.title != nil {
                    if yAxis.title.style != nil {
                        yAxis.title.style.color = colorName
                    }
                }
            }
        }
    }
}
