//
//  button.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class PopUpButton: UIButton {
    
    var wasSelected: Bool = false {
        didSet {
            if self.wasSelected {
                self.backgroundColor = Constants.darkBlueLM

            } else {
                self.backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 30 / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = Constants.BGLM.cgColor
        self.layer.borderWidth = 2.0
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var start = CGPoint(x: self.bounds.midX + 5, y: self.bounds.midY  + 7)
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addLine(to: CGPoint(x: start.x, y: start.y - 15))
        path.close()
        
        start.x -= 5
        
        path.move(to: start)
        path.addLine(to: CGPoint(x: start.x, y: start.y - 12))
        path.close()
        
        start.x -= 5
        
        path.move(to: start)
        path.addLine(to: CGPoint(x: start.x, y: start.y - 9))
        path.close()
        
        context.setLineCap(.round)
        context.setLineWidth(2)
        
        if wasSelected {
            context.setStrokeColor(UIColor.white.cgColor)
        } else {
            context.setStrokeColor(Constants.darkBlueLM.cgColor)
        }
        
        context.addPath(path.cgPath)
        context.drawPath(using: .stroke)
    }
    
}
