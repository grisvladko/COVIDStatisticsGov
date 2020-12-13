//
//  MiddleContainerDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts
import FontAwesome_swift

class MiddleContainerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data: [[String : Any]]?
    var charts: [HIChartView] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "middleContainerCell", for: indexPath) as! MiddleContainerCell
        
        guard self.data != nil else {
            cell.startActivityIndicator()
            return cell
        }
        
        setupCell(cell, indexPath)
   
        cell.contentView.layer.borderWidth = 0.8
        cell.contentView.layer.borderColor = Constants.BGLM.cgColor
        cell.backgroundColor = .white
        
        return cell
    }
    
    func setupCell(_ cell: MiddleContainerCell, _ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ChartsInitializer.functions.initFirstChart(cell, self.data!)
            setCellHeader(cell, titleText: "מגמת שינוי במאומתים וקצב ההכפלה", .titleAndInfo, infoText: "% שינוי בממוצע מאומתים חדשים שבועי ומספר הימים להכפלת הנדבקים (בסוגריים)", .infoCircle)
        case 1:
            ChartsInitializer.functions.initSecondChart(cell, self.data!)
            setCellHeader(cell, titleText: "מספר החולים קשה וקריטי", .titleOnly, infoText: nil, nil)
        case 2:
            ChartsInitializer.functions.initThirdChart(cell, self.data!)
            setCellHeader(cell, titleText: "מספר המאומתים החדשים מחוץ לאזורי ההתפשטות", .titleAndInfo, infoText: "הנתונים אינם כוללים מאומתים מישובים אדומים, מוסדות גריאטריים וחוזרים מחו״ל", .infoCircle)
            cell.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], 10)
        default: break
        }
    }
    
    func setCellHeader(_ cell: MiddleContainerCell,  titleText: String, _ option: CellHeader.Options , infoText: String?, _ infoIcon: FontAwesome?) {
        var header: CellHeader!
        guard cell.chart != nil else { return }
        
        if infoText == nil {
            header = CellHeader.init(.zero, option, titleText)
        } else {
            header = CellHeader.init(.zero, option, titleText, infoText!, infoIcon!)
        }
        
        header.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            header.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor),
            header.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
            header.bottomAnchor.constraint(equalTo: cell.chart!.topAnchor)
        ])
    }
}
