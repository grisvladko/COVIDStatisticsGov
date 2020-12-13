//
//  BottomContainerCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts
import MaterialActivityIndicator

class BottomContainerCell: UICollectionViewCell, HIChartViewDelegate {
    
    enum CellChartType {
        case epidemicCurve
        case spreadForAgeAndGender
        case heavilySick
        case pie
        case infected
    }
    
    var chartType: CellChartType?
    var data: [[String: Any]]?
    var chart: HIChartView?
    var tableViewContainer: UIView?
    var activity: MaterialActivityIndicatorView?
    
    func chartViewDidLoad(_ chart: HIChartView!) {
        self.stopActivityIndicator()
    }
    
    func startActivityIndicator() {
        let activity = MaterialActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activity.color = .gray
        activity.lineWidth = 5
        activity.startAnimating()
        activity.center = self.contentView.center
        
        self.activity = activity
        self.contentView.addSubview(activity)
    }
    
    func stopActivityIndicator() {
        self.activity?.removeFromSuperview()
        self.activity?.stopAnimating()
        self.activity = nil
    }
}

extension BottomContainerCell: ChartDataUpdateDelegate {
    
    func updateChart(_ option: ChartsInitializer.Options) {
        guard self.chart != nil else { return }
        guard self.data != nil else { return }
        guard self.chartType != nil else { return }
        
        ChartsInitializer.functions.updateChart(self.chart!, self.chartType!, option, self.data!) 
    }
}

extension BottomContainerCell: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        
        if !isDarkModeOn {
            self.backgroundColor = Constants.cellBGDM
        } else {
            self.backgroundColor = .white
        }
        
        if self.chart != nil && self.chartType != nil {
            ChartsInitializer.functions.updateChartModeForBottomContainer(self.chart!, self.chartType!, isDarkModeOn)
        }
    }
}
