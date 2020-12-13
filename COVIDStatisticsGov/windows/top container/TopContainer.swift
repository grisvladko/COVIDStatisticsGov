//
//  StatisticsContainer.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 19/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts

class TopContainer: UIView {
    
    var collectionView: UICollectionView!
    var containerDelegate: TopContainerDelegate!
    
    var popChart: UIView?
    var popLabel: UIView?
    
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
        guard self.collectionView != nil else { return }
        
        self.collectionView.bounds = self.bounds
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func setup() {
        self.backgroundColor = .clear
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
        containerDelegate = TopContainerDelegate( (collectionView.bounds.width / 2) - 20)
      
        collectionView.backgroundColor = .clear
        collectionView.register(TopContainerCell.self, forCellWithReuseIdentifier: "containerCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = containerDelegate
        collectionView.dataSource = containerDelegate
        collectionView.isScrollEnabled = false
        
        self.pinView(collectionView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(performShadowOperation(_:)), name: .init(rawValue: "shadowOp"), object: nil)
    }
    
    @objc func performShadowOperation(_ notification: Notification) {
        guard let dict = notification.object as? [String: Any] else { return }
        guard let state = dict["state"] as? PopState else { return }
        guard let indexPath = dict["indexPath"] as? IndexPath else { return }

        switch state {
        case .open: collectionView.cellForItem(at: indexPath)?.addShadow(10, 0.8)
        case .remove: collectionView.cellForItem(at: indexPath)?.removeShadow()
        }
    }
}
