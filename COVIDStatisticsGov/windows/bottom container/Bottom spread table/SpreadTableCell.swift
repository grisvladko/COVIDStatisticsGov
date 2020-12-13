//
//  SpreadTableCell.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class SpreadTableCell: UITableViewCell {
    
    var titles: [Int] = []
    var labelColor: UIColor?
    
    func setup(_ data: [String: Any]) {
          
        self.extractDataForCell(data)
        
        var spacing: CGFloat!
        
        switch UIDevice.current.orientation {
        case .landscapeLeft : spacing = 20
        case .landscapeRight : spacing = 20
        default: spacing = 15
        }
        
        var labels: [UILabel] = []
        
        for i in 0..<6 {
            let title = i < titles.count ? titles[i] : 0
            let label = UILabel()
            label.setLabel(12, "\(title)", false)
            if labelColor != nil { label.textColor = labelColor! }
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            labels.append(label)
        }
        labels[labels.count - 1].text = "אשקלון" // just for testing
        
        let stackView = makeStackView(labels, .horizontal, spacing, .fill, .fill)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.contentView.pinView(stackView, .zero)
    }
    
    func extractDataForCell(_ data: [String: Any]) {
        for key in data.keys {
            if data[key] as? Int != nil {
                titles.append(data[key] as! Int)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}
