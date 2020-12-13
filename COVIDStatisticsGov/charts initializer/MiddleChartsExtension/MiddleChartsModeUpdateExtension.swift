//
//  MiddleChartsModeUpdateExtension.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 26/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//
import Foundation
import Highcharts
import UIKit



//--------------- Middle Container Charts Mode Update ----------------//



extension ChartsInitializer {
    func updateChartModeForMiddleContainer(_ chart: HIChartView, _ type: MiddleContainerCell.ChartType, _ isDarkModeOn: Bool) {
        switch type {
            case .first : updateFirst(chart,isDarkModeOn)
            case .second : updateSecond(chart,isDarkModeOn)
            case .third : updateThird(chart,isDarkModeOn)
        }
    }
    
    func updateAreaGradient(_ linearGradient: [String: Any],_ startColorName: String, _ area: HIArea) {
        let gradient = HIColor(linearGradient: linearGradient, stops: [[0, startColorName],[1,Constants.HIClearColor]])
        area.color = gradient
    }
}
