//
//  PopUpChartInitExtension.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Highcharts
import UIKit




//--------------- PopUpChart ----------------//




extension ChartsInitializer {
    func initPopChart(_ holderView: UIView, _ yAxisTitle: String, _ data: [[String: Any]]) {

        guard let values = extractValuesFrom(data, Constants.Keys.severe, .all) else { return }
        guard let dates = getDates(data, .all) else { return }
        
        let layerView = UIView()
        layerView.layer.cornerRadius = 10
        layerView.layer.masksToBounds = true
        layerView.backgroundColor = .white
        holderView.pinView(layerView, .zero)
        
        let popChart = initBasicChartView("line", false)
        
        let crosshair = HICrosshair()
        crosshair.dashStyle = "dash"
        crosshair.width = 1
        crosshair.color = HIColor(name: "gray")
        
        let xAxis = HIXAxis()
        xAxis.min = 0
        xAxis.title = HITitle()
        xAxis.title.text = "תאריך"
        xAxis.categories = dates as? [String]
        xAxis.labels = HILabels()
        xAxis.labels.rotation = 0
        
        xAxis.crosshair = crosshair
        popChart.options.xAxis = [xAxis]
        
        let yAxis = HIYAxis()
        yAxis.gridLineWidth = 0
        yAxis.title = HITitle()
        yAxis.title.text = yAxisTitle
        yAxis.crosshair = crosshair
        popChart.options.yAxis = [yAxis]
        
        let area = HIArea()
        let gradient = HIColor(linearGradient: ["x1": 0, "x2": 0, "y1": 0, "y2": 2], stops: [[0,"rgba(88,223,255,1)"],[1,"rgba(255, 255, 255, 0.0)"]])
        area.color = gradient
        area.data = values
        area.marker = HIMarker()
        area.marker.enabled = true
        area.marker.radius = 3
        area.marker.lineWidth = 2
        area.marker.lineColor = "rgba(88,223,255,1)"
        
        popChart.options.series = [area]
        popChart.options.legend = HILegend()
        popChart.options.legend.enabled = false
        
        layerView.pinView(popChart, UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
