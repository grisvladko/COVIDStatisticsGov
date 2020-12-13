//
//  LeftTopContainerCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 21/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class LeftTopContainerCell: UIView {
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

    }
    
    func setup() {
        let l1 = UILabel(frame: .zero)
        self.addSubview(l1)
        self.backgroundColor = .clear
        l1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            l1.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            l1.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l1.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        ])
        
        l1.setLabel(18, "חולים פעילים", true)
        
        let l2 = UILabel(frame: .zero)
        self.addSubview(l2)
        l2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            l2.topAnchor.constraint(equalTo: l1.bottomAnchor,constant: 10),
            l2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l2.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        ])
        
        l2.setLabel(16, "88888888888888", true)

        
        let l3 = UILabel(frame: .zero)
        let l4 = UILabel(frame: .zero)

        self.addSubview(l3)
        self.addSubview(l4)
        
        l3.translatesAutoresizingMaskIntoConstraints = false
        l4.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            l3.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 10),
            l3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            l4.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 10),
            l4.trailingAnchor.constraint(equalTo: l3.leadingAnchor, constant: -5),
        ])
        
        l3.setLabel(12, "-391", true)
        l4.setLabel(12, "מחצות", false)
        
        //bottom
        
        let l5 = UILabel(frame: .zero)
        let l6 = UILabel(frame: .zero)
        let l7 = UILabel(frame: .zero)
        let l8 = UILabel(frame: .zero)
        let l9 = UILabel(frame: .zero)
        let l10 = UILabel(frame: .zero)
        
        self.addSubview(l5)
        self.addSubview(l6)
        self.addSubview(l7)
        self.addSubview(l8)
        self.addSubview(l9)
        self.addSubview(l10)
 
        l5.translatesAutoresizingMaskIntoConstraints = false
        l6.translatesAutoresizingMaskIntoConstraints = false
        l7.translatesAutoresizingMaskIntoConstraints = false
        l8.translatesAutoresizingMaskIntoConstraints = false
        l9.translatesAutoresizingMaskIntoConstraints = false
        l10.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            l10.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            l10.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            l9.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            l9.trailingAnchor.constraint(equalTo: l10.leadingAnchor, constant: -15),
            l8.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            l8.trailingAnchor.constraint(equalTo: l9.leadingAnchor, constant: -15),
            l7.bottomAnchor.constraint(equalTo: l10.topAnchor, constant: -15),
            l7.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            l6.bottomAnchor.constraint(equalTo: l9.topAnchor, constant: -15),
            l6.trailingAnchor.constraint(equalTo: l7.leadingAnchor, constant: -15),
            l5.bottomAnchor.constraint(equalTo: l8.topAnchor, constant: -15),
            l5.trailingAnchor.constraint(equalTo: l6.leadingAnchor, constant: -15)
        ])
        
        l5.setLabel(12, "בי״ח", false)
        l6.setLabel(12, "מלון", false)
        l7.setLabel(12, "ביתֿ / קהילה", false)
        l8.setLabel(12, "1,075", true)
        l9.setLabel(12, "2,086", true)
        l10.setLabel(12, "17,993", true)
    }
}
