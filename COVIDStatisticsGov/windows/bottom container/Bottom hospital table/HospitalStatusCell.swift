//
//  HospitalStatusCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class HospitalStatusCell: UITableViewCell {
    
    var titles: [Int] = []
    var labelColor: UIColor?
    
    func setup(_ data: [String: Any]) {
        
        self.extractDataForCell(data)
        
        var titleSpacing: CGFloat = UIScreen.main.bounds.width / 15
        var lastSpacing: CGFloat = 0
        var stackXConstant: CGFloat = 0
            switch UIDevice.current.orientation {
            case .landscapeLeft:
                lastSpacing = titleSpacing
                stackXConstant = -titleSpacing
            case .landscapeRight:
                lastSpacing = titleSpacing
                stackXConstant = -titleSpacing
            default:
                titleSpacing = 5
                lastSpacing = titleSpacing * 0.4
                stackXConstant = -10
        }
        
        let titleLabel = UILabel()
        titleLabel.setLabel(12, "אוגוסטה ויקטוריה", false)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let lastLabel = UILabel()
        lastLabel.setLabel(12, "\(titles[0])", false)
        lastLabel.textAlignment = .center
        lastLabel.adjustsFontSizeToFitWidth = true
        lastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if self.labelColor != nil {
            titleLabel.textColor = labelColor
            lastLabel.textColor = labelColor
        }
        let barWidth = UIScreen.main.bounds.width / 10
        let capacity = makeViewWithPercentBar(barWidth, "\(titles[0])")
        let corona = makeViewWithPercentBar(barWidth, "\(titles[0])")
        
        let stackView = makeStackView([capacity, corona], .horizontal, 10, .fill, .fill)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(lastLabel)
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            lastLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: lastSpacing),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -(titleSpacing)),
            titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: stackView.rightAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: stackXConstant),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func makeViewWithPercentBar(_ barWidth: CGFloat, _ text: String) -> UIView {
        let progressBar = HorizontalProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabel(12, text, false)
        if self.labelColor != nil { label.textColor = labelColor }
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(progressBar)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 4),
            progressBar.widthAnchor.constraint(equalToConstant: barWidth),
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            progressBar.topAnchor.constraint(equalTo: view.topAnchor),
            progressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -5),
            label.rightAnchor.constraint(equalTo: progressBar.leftAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }
    
    func extractDataForCell(_ data: [String: Any]) {
        for key in data.keys {
            if data[key] as? Int != nil {
                titles.append(data[key] as! Int)
            }
        }
        if titles.isEmpty {
            titles = [0,0,0,0]
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}

class HorizontalProgressBar: UIView {
    
    var width: CGFloat = UIScreen.main.bounds.width / 10
    var color: UIColor = Constants.lightBlueLM
    var progress: CGFloat = CGFloat(Double.random(in: 0...1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let progressView = UIView()
        progressView.roundCorners([.layerMinXMaxYCorner,.layerMinXMinYCorner], 10)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = color
        progressView.clipsToBounds = true
        self.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressView.heightAnchor.constraint(equalTo: self.heightAnchor),
            progressView.widthAnchor.constraint(equalToConstant: width * progress)
        ])
        
        self.backgroundColor = Constants.BGLM
        self.roundCorners([.layerMinXMaxYCorner,.layerMinXMinYCorner], 10)
    }
}
