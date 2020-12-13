//
//  MiddleContainerCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import MaterialActivityIndicator
import Highcharts

class MiddleContainerCell: UICollectionViewCell, HIChartViewDelegate {
    
    enum ChartType {
        case first
        case second
        case third
    }
    
    var activity: MaterialActivityIndicatorView?
    var chart: HIChartView?
    var chartType: ChartType?
    
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

extension MiddleContainerCell: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        guard chartType != nil else { return }
        guard chart != nil else { return }
        
        if !isDarkModeOn {
            self.backgroundColor = Constants.cellBGDM
        } else {
            self.backgroundColor = .white
        }
        
        ChartsInitializer.functions.updateChartModeForMiddleContainer(chart!, chartType!, isDarkModeOn)
    }
}
