//
//  BottomContainer.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts

class BottomContainer: UIView {

    var collectionView: UICollectionView!
    var containerDelegate: BottomContainerDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.bounds = self.bounds
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func setup() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
        containerDelegate = BottomContainerDelegate()
        collectionView.register(BottomContainerCell.self, forCellWithReuseIdentifier: "bottomContainerCell")
        
        self.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.delegate = containerDelegate
        collectionView.dataSource = containerDelegate
        collectionView.isScrollEnabled = false
        
        self.pinView(collectionView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
