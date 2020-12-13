//
//  ContainerCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 19/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import MaterialActivityIndicator

class TopContainerCell: UICollectionViewCell {
    
    var activity: MaterialActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add shadow on cell
        backgroundColor = .clear // very important

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setup(_ view : UIView) {
        self.pinView(view, UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0))
    }
}

extension TopContainerCell: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.contentView.backgroundColor = Constants.cellBGDM
        } else {
            self.contentView.backgroundColor = .white
        }
    }
}
