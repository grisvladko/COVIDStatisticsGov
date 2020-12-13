//
//  RightTopContainerCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class RightTopContainerCell: UIView {

    var titleLabel: UILabel!
    var infectedCount: UILabel!
    var fromMidnight: UILabel!
    var yesterday: UILabel!
    var hard: UILabel!
    var avarage: UILabel!
    
    var l2Text: String!
    var l3Text: String!
    var l5Text: String!
    var l9Text: String!
    var l10Text: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        l2Text = "888888888"
        l3Text = "+542" //interpolate
        l5Text = "+123 |" //interpolate
        l9Text = "231"
        l10Text = "909"
        
        titleLabel = UILabel(frame: .zero)
        self.addSubview(titleLabel)
        self.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        ])
        
        setLabel(titleLabel, 18, "סה״כ מאומתים\n(נדבקים)", true)
        titleLabel.numberOfLines = 2
        
        let l2 = UILabel(frame: .zero)
        self.addSubview(l2)
        l2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            l2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            l2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l2.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        ])
    
        setLabel(l2, 16, l2Text, true)
        
        let titles = ["אתמול",l5Text,"מחצות",l3Text]
        var labels: [UILabel] = []
        var isBold = false
        
        for i in 0...3 {
            let label = UILabel(frame: .zero)
            setLabel(label, 12, titles[i]!, isBold)
            labels.append(label)
            isBold = !isBold
        }
        
        let stackView = makeStackView(labels, .horizontal, 7)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        
        //bottom
        let l9 = UILabel(frame: .zero)
        let l10 = UILabel(frame: .zero)
        
        self.addSubview(l9)
        self.addSubview(l10)
        
        l9.translatesAutoresizingMaskIntoConstraints = false
        l10.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            l10.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            l10.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            l9.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            l9.trailingAnchor.constraint(equalTo: l10.leadingAnchor, constant: -30)
        ])
        
        setLabel(l9, 12, l9Text, false)
        setLabel(l10, 12, l10Text, false)
        
        let legend = makeLegendStackView(["קשה","בינוני"], [Constants.redLegend, Constants.yellowLegend], 25, 8)
        legend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(legend)
        
        NSLayoutConstraint.activate([
            legend.bottomAnchor.constraint(equalTo: l10.topAnchor, constant: -10),
            legend.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25)
        ])
    }
    
    func setLabel(_ label: UILabel, _ fontSize: CGFloat, _ text: String, _ isBold: Bool) {
        label.textAlignment = .right
        label.text = text
        if isBold {
            label.font = UIFont.boldSystemFont(ofSize:fontSize)
        } else {
            label.font = label.font.withSize(fontSize)
        }
        label.textColor = Constants.darkBlueLM
        label.adjustsFontSizeToFitWidth = true
    }
}
