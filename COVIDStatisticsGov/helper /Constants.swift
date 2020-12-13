//
//  Constants.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 27/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import UIKit
import Highcharts

class Constants {
    
    class Keys {
        static let newCases = "New Cases"
        static let totalCases = "Total Cases"
        static let date = "Date"
        static let totalTested = "סה\"כ נבדקים Total Tested"
        static let newRecovered = "New Recovered"
        static let severe = "קשה Severe"
    }
    
    //dark mode colors
    static let redLineDM = UIColor(red: 240/255, green: 70/255, blue: 94/255, alpha: 1)
    static let BGDM = UIColor(red: 73/255, green: 102/255, blue: 122/255, alpha: 1)
    static let cellBGDM = UIColor(red: 56/255, green: 79/255, blue: 95/255, alpha: 1)
    static let peachDM = UIColor(red: 255/255, green: 143/255, blue: 110/255, alpha: 1)
    static let greenDM = UIColor(red: 170/255, green: 255/255, blue: 146/255, alpha: 1)
    static let lightBlueDM = UIColor(red: 48/255, green: 231/255, blue: 240/255, alpha: 1)
    
    //regular colors light mode = LM
    static let BGLM = UIColor(red: 216/255, green: 216/255, blue: 217/255, alpha: 1.0)
    static let darkBlueLM = UIColor(red: 26/255, green: 33/255, blue: 56/255, alpha: 1)
    static let lightBlueLM = UIColor(red: 88/255, green: 223/255, blue: 255/255, alpha: 1)
    static let greenLM = UIColor(red: 182/255, green: 202/255, blue: 81/255, alpha: 1)
    static let deemBlueLM = UIColor(red: 30/255, green: 137/255, blue: 138/255, alpha: 1)
    static let redLegend = UIColor(red: 251/255, green: 83/255, blue: 119/255, alpha: 1)
    static let yellowLegend = UIColor(red: 230/255, green: 186/255, blue: 87/255, alpha: 1)
    static let infoBG = UIColor(red: 230/255, green: 241/255, blue: 244/255, alpha: 1)
    
    //real usage string colors for highcharts
    
    static let HILightBlueLM = "rgba(88,223,255,0.6)"
    static let HILabelDarkBlue = "rgba(26,33,56,1)"
    static let HILightBlueDM = "rgba(101,233,235,0.6)"
    static let HIClearColor = "rgba(255, 255, 255, 0.0)"
    static let HIGreenDM = "rgba(170,255,146,0.6)"
    static let HIDeemBlueLM = "rgba(30,137,138,1)"
    static let HIPeachDM = "rgba(255,143,110,1)"
    static let HIGreenLM = "b6ca51"
}
 
enum PopViewType {
    case popChart
    case infoLabel
}

enum PopState {
    case remove
    case open
}
