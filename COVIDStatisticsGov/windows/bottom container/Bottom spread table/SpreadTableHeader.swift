//
//  SpreadTableHeader.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class SpreadTableHeader: UITableViewHeaderFooterView {
    
    var spreadContentView: UIView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        spreadContentView = SpreadHeaderContentView()
        self.addSubview(spreadContentView)
        self.pinView(spreadContentView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

class SpreadHeaderContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titles = ["יישוב","מאומתים","חולים פעילים","חולים חדשים ב-7 ימים האחרונים","בדיקות ב-7 ימים האחרונים","חולים פעילים ל-10,000 נפש"]
    
    func setup() {
        var spacing: CGFloat!
        
        switch UIDevice.current.orientation {
            case .landscapeLeft : spacing = 20
            case .landscapeRight : spacing = 20
            default: spacing = 15
        }
        
        var labels: [UILabel] = []
        
        for i in stride(from: titles.count - 1, through: 0, by: -1) {
            let label = UILabel()
            label.setLabel(11, titles[i], false)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            labels.append(label)
        }
        
        let stackView = makeStackView(labels, .horizontal, spacing, .fill, .fill)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        self.pinView(stackView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        self.backgroundColor = Constants.infoBG
    }
}

extension SpreadHeaderContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.backgroundColor = Constants.darkBlueLM
        } else {
            self.backgroundColor = Constants.infoBG
        }
    }
    
    
}
