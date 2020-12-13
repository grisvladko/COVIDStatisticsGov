//
//  HospitalStatusHeader.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class HospitalStatusHeader: UITableViewHeaderFooterView {
    var hospitalContentView: UIView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        hospitalContentView = HospitalStatusHeaderContentView()
        self.addSubview(hospitalContentView)
        self.pinView(hospitalContentView, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

class HospitalStatusHeaderContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titles = ["בית חולים","% תפוסה כללי","% תפוסת קורונה","צוות בבידוד"]
    
    func setup() {
        titles.reverse()
        var spacing: CGFloat!
        
        switch UIDevice.current.orientation {
            case .landscapeLeft : spacing = 20
            case .landscapeRight : spacing = 20
            default: spacing = 15
        }
        
        var labels: [UILabel] = []
        
        for i in 0..<titles.count {
            let label = UILabel()
            label.setLabel(12, titles[i], false)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            labels.append(label)
        }
        
        let stackView = makeStackView(labels, .horizontal, spacing, .fill, .fill)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.pinView(stackView, .zero)
        self.backgroundColor = Constants.infoBG
    }
}

extension HospitalStatusHeaderContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.backgroundColor = Constants.darkBlueLM
        } else {
            self.backgroundColor = Constants.infoBG
        }
    }
}
