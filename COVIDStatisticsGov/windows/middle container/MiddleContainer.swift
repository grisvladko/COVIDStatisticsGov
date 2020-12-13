//
//  SpreadStatisticsContainer.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts

class MiddleContainer: UIView {
    
    var collectionView: UICollectionView!
    var containerDelegate: MiddleContainerDelegate!
    
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
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        containerDelegate = MiddleContainerDelegate()
        
        collectionView.backgroundColor = .clear
        self.backgroundColor = .clear
        collectionView.register(MiddleContainerCell.self, forCellWithReuseIdentifier: "middleContainerCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    
        collectionView.delegate = containerDelegate
        collectionView.dataSource = containerDelegate
        collectionView.isScrollEnabled = false
        
        self.pinView(collectionView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}


