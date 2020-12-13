//
//  BottomContainerDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import FontAwesome_swift

class BottomContainerDelegate: NSObject, UICollectionViewDelegate,      UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let firstCellHeaderData = (title: "עקומה אפידמית", legendTitles: ["מאומתים מצטבר","מחלימים חדשים","מאומתים חדשים"], legendColors: [Constants.lightBlueLM, .darkGray, Constants.deemBlueLM])
    
    let secondCellHeaderData = (title: "חולים קשה ומונשמים", legendTitles: ["נפטרים","מונשמים","חולים קשים"], legendColors: [Constants.deemBlueLM, Constants.lightBlueLM ,Constants.greenLM])
    
    let thirdCellHeaderData = (title: "פיזור מאומתים לפי גיל ומגדר", legendTitles:["נשים","גברים"] , legendColors: [Constants.greenLM , Constants.lightBlueLM])
    
    let lastCellHeaderData = (title: "בדיקות לאיתור נדבקים", legendTitles: ["מאומתים","בדיקות"] , legendColors: [Constants.lightBlueLM ,Constants.deemBlueLM], info: "הנתונים אינם כוללים מידע על בדיקות לאבחון החלמה")
    
    let thirdCellButtonData = ["מצב קשה","מונשמים","נפטרים","מאומתים"]
    let generalCellButtonData = ["עד עכשיו","שבוע אחרון","שבועיים אחרונים","חודש אחרון"]
    
    var data: [[String : Any]]?
    
    var reversedArrowTitle = NSMutableAttributedString()
    
    let arrowDown = NSMutableAttributedString(string: "\u{2304}", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 20)!])
    
    let arrowUp = NSMutableAttributedString(string: "\u{2303}", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 20)!])
    
    let spacing = NSMutableAttributedString(string: "  ", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!])
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomContainerCell", for: indexPath) as! BottomContainerCell
        
        cell.clean()
        
        guard self.data != nil else {
            cell.startActivityIndicator()
            return cell
        }
        
        setupCell(cell, indexPath)
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func setupCell(_ cell: BottomContainerCell, _ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ChartsInitializer.functions.initEpidemicCurveChart(cell, self.data!, .biWeek)
            setCellHeader(cell, titleText: "עקומה אפידמית", CellHeader.Options.all, infoText: "מספר הנבדקים היום הינו כפול מהמספר לפני 67 ימים", .lightbulb, .timeLine)
            cell.data = self.data
            cell.chartType = .epidemicCurve
        case 1:
            ChartsInitializer.functions.initHeavilySickChart(cell, self.data!, .biWeek)
            setCellHeader(cell, titleText: "חולים קשה ומונשמים", CellHeader.Options.titleAndChevron, infoText: nil, nil, .timeLine)
            cell.data = self.data
            cell.chartType = .heavilySick
        case 2:
            ChartsInitializer.functions.initSpreadChart(cell, self.data!, .biWeek)
            setCellHeader(cell, titleText: "פילוג מדדים שונים על פי גיל ומגדר", CellHeader.Options.titleAndChevron, infoText: nil, nil, .sickSituation)
            cell.data = self.data
            cell.chartType = .spreadForAgeAndGender
        case 3:
            let view = BottomSpreadTable(.zero, self.data!)
            cell.tableViewContainer = view
            cell.pinView(view, UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10))
            cell.stopActivityIndicator()
            setCellHeader(cell, titleText: "אזורי התפשטות", CellHeader.Options.titleOnly, infoText: nil, nil, nil)
        case 4: ChartsInitializer.functions.initHealthStuffChart(cell, self.data!)
            setCellHeader(cell, titleText: "אנשי צוות בריאות בבידוד", CellHeader.Options.titleOnly, infoText: nil, nil, nil)
        case 5:
            let view = BottomHospitalStatusTable(.zero, self.data!)
            cell.tableViewContainer = view
            cell.pinView(view, UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10))
            cell.stopActivityIndicator()
            setCellHeader(cell, titleText: "סטטוס בתי חולים", CellHeader.Options.titleOnly, infoText: nil, nil, nil)
        case 6:
            ChartsInitializer.functions.initInfectedExamChart(cell, self.data!)
            setCellHeader(cell, titleText: "בדיקות לאיתור נדבקים", CellHeader.Options.titleAndInfo, infoText: "הנתונים אינם כוללים מידע על בדיקות לאיבחון החלמה", .infoCircle, nil)
        default: break
        }
    }
    
    func setCellHeader(_ cell: BottomContainerCell,  titleText: String, _ option: CellHeader.Options , infoText: String?, _ infoIcon: FontAwesome?, _ chevronOptions: ChevronView.Options?) {
        var header: CellHeader!
        
        if chevronOptions != nil {
            header = CellHeader.init(.zero, option, titleText, infoText, infoIcon, chevronOptions!)
            header.delegate = cell
        } else if infoText == nil {
            header = CellHeader.init(.zero, option, titleText)
        } else {
            header = CellHeader.init(.zero, option, titleText, infoText!, infoIcon!)
        }
        
        header.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: cell.topAnchor),
            header.leftAnchor.constraint(equalTo: cell.leftAnchor),
            header.rightAnchor.constraint(equalTo: cell.rightAnchor),
        ])
        
        if cell.chart != nil {
            header.bottomAnchor.constraint(equalTo: cell.chart!.topAnchor).isActive = true
        } else if cell.tableViewContainer != nil {
            header.bottomAnchor.constraint(equalTo: cell.tableViewContainer!.topAnchor).isActive = true
        }
        
    }
}

