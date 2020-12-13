//
//  HeaderView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let contentView = HeaderContentView()
        self.addSubview(contentView)
        self.pinView(contentView, UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
}

class HeaderContentView: UIView {
    
    let headerTitle = "מדדי התפשטות בהסתכלות\n     שבועית"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], 10)
        self.backgroundColor = .white
        let label = UILabel(frame: .zero)
        label.setLabel(26, headerTitle , true)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension HeaderContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.backgroundColor = Constants.cellBGDM
        } else {
            self.backgroundColor = .white
        }
    }
    
    
}
