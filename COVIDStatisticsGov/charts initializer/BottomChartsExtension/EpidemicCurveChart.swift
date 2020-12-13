//
//  EpidemicCurveChart.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit

extension ChartsInitializer {
    func initEpidemicCurveChart(_ cell: BottomContainerCell, _ data: [[String: Any]], _ extractionOption: Options) {
        
        guard let values = extractValuesFrom(data, Constants.Keys.newCases, extractionOption) else { return }
        guard let dates = getDates(data, extractionOption) else { return }
        
        let curveChart = initBasicChartView("column", true)
        
        let crosshair = HICrosshair()
        crosshair.width = 1
        crosshair.color = HIColor(name: "gray")
        crosshair.zIndex = 5
        crosshair.dashStyle = "dash"
        
        let xAxis = HIXAxis()
        xAxis.crosshair = crosshair
        xAxis.labels = HILabels()
        xAxis.labels.style = HICSSObject()
        xAxis.labels.style.color = Constants.HILabelDarkBlue
        xAxis.title = HITitle()
        xAxis.title.style = HICSSObject()
        xAxis.title.text = "תאריך בדיקה"
        xAxis.min = 0
        xAxis.categories = dates as? [String]
        
        let yAxis1 = HIYAxis()
        yAxis1.labels = HILabels()
        yAxis1.labels.enabled = true
        yAxis1.labels.style = HICSSObject()
        yAxis1.labels.style.color = Constants.HILightBlueLM
        yAxis1.title = HITitle()
        yAxis1.title.style = HICSSObject()
        yAxis1.title.text = "מספר מקרים מצטבר"
        yAxis1.crosshair = crosshair
        yAxis1.min = 0
        
        let yAxis2 = HIYAxis()
        yAxis2.title = HITitle()
        yAxis2.title.style = HICSSObject()
        yAxis2.labels = HILabels()
        yAxis2.labels.enabled = true
        yAxis2.labels.style = HICSSObject()
        yAxis2.labels.style.color = Constants.HIDeemBlueLM
        yAxis2.title.rotation = 270
        yAxis2.title.text = "מספר מקרים חדשים"
        yAxis2.min = 0
        yAxis2.opposite = true
        
        let column1 = HIColumn()
        column1.data = values.shuffled()
        column1.yAxis = 1
        column1.name = "מאומתים חדשים"
        column1.borderRadius = 5
        column1.pointWidth = 10
        column1.color = HIColor(rgb: 30, green: 137, blue: 138)
        
        let column2 = HIColumn()
        column2.name = "מחלימים מצטבר"
        column2.data = values.shuffled()
        column2.borderRadius = 5
        column2.pointWidth = 10
        column2.color = HIColor(name: "gray")
        
        
        let area = HIArea()
        area.name = "מאומתים מצטבר"
        area.data = values.shuffled()
        let gradient = HIColor(linearGradient: ["x1": 0, "x2": 0, "y1": 0, "y2": 1], stops: [[0,"rgba(88,223,255,1)"],[1,"rgba(255, 255, 255, 0.0)"]])
        area.color = gradient
        area.lineColor = HIColor(name: "rgba(88,223,255,1)")
        area.marker = HIMarker()
        area.marker.color = HIColor(name: "rgba(88,223,255,1)")
        area.events = HIEvents()
    
        let tooltip = HITooltip()
        tooltip.shared = true

        curveChart.options.tooltip = tooltip
        curveChart.options.xAxis = [xAxis]
        curveChart.options.yAxis = [yAxis1,yAxis2]
        curveChart.options.series = [column1,column2,area]
        curveChart.options.legend.itemStyle = HICSSObject()
        curveChart.options.legend.itemStyle.color = Constants.HILabelDarkBlue
        curveChart.options.legend.align = "right"
        curveChart.options.legend.layout = "horizontal"
        curveChart.options.legend.verticalAlign = "top"
        curveChart.options.legend.rtl = true
        
        curveChart.delegate = cell
        cell.chart = curveChart
        cell.chartType = .epidemicCurve
        
        cell.contentView.pinView(curveChart, UIEdgeInsets(top: cell.contentView.frame.height / 4, left: 20, bottom: 20, right: 20))
    }
    
    func updateEpidemicCurveMode(_ chart: HIChartView, _ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 1],Constants.HILightBlueDM, area)
                } else if let column = serie as? HIColumn {
                    if column.name == "מאומתים חדשים" {
                        column.color = HIColor(name: Constants.HIPeachDM)
                    } else {
                        column.color = HIColor(name: Constants.HIGreenDM)
                    }
                }
            }
            updateEpidemicChartAxesColors(chart, ["white",
                                                  Constants.HILightBlueDM,
                                                  Constants.HIPeachDM])
        } else {
            for serie in chart.options.series {
                if let area = serie as? HIArea {
                    updateAreaGradient(["x1": 0, "x2": 0, "y1": 0, "y2": 1],Constants.HILightBlueLM, area)
                } else if let column = serie as? HIColumn {
                    if column.name == "מאומתים חדשים" {
                        column.color = HIColor(name: Constants.HIDeemBlueLM)
                    } else {
                        column.color = HIColor(name: "gray")
                    }
                }
            }
            updateEpidemicChartAxesColors(chart, [Constants.HILabelDarkBlue,
                                                  Constants.HILightBlueLM,
                                                  Constants.HIDeemBlueLM])
        }
        
        chart.updateOptions()
    }
    
    func updateEpidemicChartAxesColors(_ chart: HIChartView, _ colors: [String]) {
        chart.options.xAxis[0].labels.style.color = colors[0]
        chart.options.yAxis[0].labels.style.color = colors[1]
        chart.options.yAxis[1].labels.style.color = colors[2]
        chart.options.xAxis[0].title.style.color = colors[0]
        chart.options.yAxis[0].title.style.color = colors[0]
        chart.options.yAxis[1].title.style.color = colors[0]
        chart.options.legend.itemStyle.color = colors[0]
    }
}
