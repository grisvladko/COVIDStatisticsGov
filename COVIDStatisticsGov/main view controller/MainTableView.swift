//
//  MainTableView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class MainTableView: UITableView {
    
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateConstraints), name: UIDevice.orientationDidChangeNotification , object:  nil)
    }
    
    @objc func sendUpdateConstraints() {
        self.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()

        self.topConstraint.constant = (UIScreen.main.bounds.height / 6)
    }
}

