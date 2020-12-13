//
//  DataDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import UIKit

protocol DataDelegate {
    func updateData(newData: [[String: Any]])
}

protocol DataSetupDelegate : UIView {
    func setupWithData(_ data: [[String: Any]])
}

protocol PopViewDelegateProtocol {
    func setIndexPath(_ indexPath: IndexPath)
}

protocol ChartDataUpdateDelegate {
    func updateChart(_ option: ChartsInitializer.Options) 
}

protocol DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) 
}
