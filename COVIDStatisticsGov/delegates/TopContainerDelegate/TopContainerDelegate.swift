//
//  TopContainerDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts

class TopContainerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data: [[String: Any]]?
    var height: CGFloat!
    var width: CGFloat!
    var openChartButtons: [PopUpButton] = []
    let titlesForChart = ["כמות מונשמים","כמות נפטרים","כמות מחלימים","מספר בדיקות יומיות"]
    
    var views: [DataSetupDelegate] {
        let frame = CGRect(x: 0, y: 0, width: height, height: height)
        let views: [DataSetupDelegate] = [ActiveSickCellContentView(frame: frame),
                                          ConfirmedSickCellContentView(frame: frame),
                                          RespiratoryContentView(frame: frame),
                                          HeavilySickCellContentView(frame: frame),
                                          PositiveTestsContentView(frame: frame),
                                          PassedAwayContentView(frame: frame)]
        return views
    }
    
    init( _ cellWidth: CGFloat) {
        self.width = cellWidth
        self.height = cellWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "containerCell", for: indexPath) as! TopContainerCell
        
        guard data != nil else {
            cell.startActivityIndicator()
            return cell
        }
        
        cell.stopActivityIndicator()
        let contentView = self.setCellContentView(views[indexPath.row])
        
        //done for cells with an open chart button
        setCellButtonDelegate(contentView, indexPath)
        
        cell.contentView.pinView(contentView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        return cell
    }
    
    func setCellContentView(_ view: DataSetupDelegate) -> DataSetupDelegate {
        guard self.data != nil else { return view }
        view.setupWithData(self.data!)
        return view
    }
    
    func setCellButtonDelegate(_ view: UIView, _ indexPath: IndexPath ) {
        guard view as? PopViewDelegateProtocol != nil else { return }
        (view as! PopViewDelegateProtocol).setIndexPath(indexPath)
    }
}
