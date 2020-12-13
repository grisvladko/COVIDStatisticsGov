//
//  PopViewDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 20/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts

class PopViewDelegate: NSObject {
    
    let chartData: [[String: Any]]?
    let cellIndexPath: IndexPath
    
    var isDarkModeOn: Bool?
    var infoLabelView: PopBackgroundView?
    var buttonToUpdate: PopUpButton?
    var chartView: PopBackgroundView?
    
    init(_ cellIndexPath: IndexPath, _ chartData: [[String: Any]]?) {
        self.cellIndexPath = cellIndexPath
        self.chartData = chartData
    }
    
    func popInfoLabel(_ holder: UIView, _ button: UIButton, _ labelText: String) {
        guard let mainView = holder.isVisible(button).1 else {return}
        
        let point = button.convert(button.center, to: mainView)
        let dimention = mainView.bounds.width / 1.2
        
        self.infoLabelView = PopBackgroundView()
        infoLabelView!.translatesAutoresizingMaskIntoConstraints = false
        
        let layerView = UIView()
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 10
        layerView.layer.masksToBounds = true
        layerView.layer.borderWidth = 2
        layerView.layer.borderColor = Constants.darkBlueLM.cgColor
        infoLabelView!.pinView(layerView, .zero)
        
        let label = UILabel()
        label.setLabel(14, labelText, false)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        layerView.pinView(label, UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        mainView.addSubview(self.infoLabelView!)
        
        if point.y < mainView.center.y {
            self.infoLabelView!.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        } else {
            self.infoLabelView!.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
        }
        self.infoLabelView!.widthAnchor.constraint(equalToConstant: dimention).isActive = true
        self.infoLabelView!.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        
        let remove = UITapGestureRecognizer(target: self, action: #selector(removeInfo(_:)))
        allowsSubviewTouchesOf(mainView, false, [self.infoLabelView!])
        mainView.addGestureRecognizer(remove)
    }
    
    func popView(_ holder: UIView, _ yAxisTitle: String ,_ button: PopUpButton, _ data: [[String : Any ]]){
        
        guard let mainView = holder.isVisible(button).1 else {return}
        buttonToUpdate = button
        
        let point = button.convert(button.center, to: mainView)
        let dimention = mainView.bounds.width / 1.2
                
        self.chartView = PopBackgroundView()
        self.chartView!.translatesAutoresizingMaskIntoConstraints = false
        self.chartView!.backgroundColor = .clear
    
        ChartsInitializer.functions.initPopChart(self.chartView!, yAxisTitle, data)

        mainView.addSubview(self.chartView!)
        
        if point.y < mainView.center.y {
            self.chartView!.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        } else {
            self.chartView!.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
        }
        self.chartView!.widthAnchor.constraint(equalToConstant: dimention).isActive = true
        self.chartView!.heightAnchor.constraint(equalToConstant: dimention).isActive = true
        self.chartView!.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        
        button.wasSelected = !button.wasSelected
        button.setNeedsDisplay()
        
        NotificationCenter.default.post(name: .init(rawValue: "shadowOp"), object: ["state": PopState.open, "indexPath": self.cellIndexPath])
        
        let remove = UITapGestureRecognizer(target: self, action: #selector(remove(_:)))
        mainView.addGestureRecognizer(remove)
        allowsSubviewTouchesOf(mainView, false, [self.chartView!])
    }
    
    func allowsSubviewTouchesOf(_ view: UIView, _ isAllowed: Bool, _ allowedViews: [UIView]?) {
        for subview in view.subviews {
            if allowedViews != nil {
                if allowedViews!.contains(subview) {
                    continue
                }
            }
            subview.isUserInteractionEnabled = isAllowed
        }
    }
    
    @objc func remove(_ p: UITapGestureRecognizer) {
        
        self.buttonToUpdate!.wasSelected = !self.buttonToUpdate!.wasSelected
        self.chartView?.removeShadow()
        self.chartView?.removeFromSuperview()
        self.chartView = nil
        
        NotificationCenter.default.post(name: .init(rawValue: "shadowOp"), object: ["state": PopState.remove, "indexPath": self.cellIndexPath])
        
        guard let v = p.view else { return }
        allowsSubviewTouchesOf(v, true, nil)
        v.removeGestureRecognizer(p)
    }
    
    @objc func removeInfo(_ p: UITapGestureRecognizer) {
        self.infoLabelView?.removeShadow()
        self.infoLabelView?.removeFromSuperview()
        self.infoLabelView = nil
        
        guard let v = p.view else { return }
        allowsSubviewTouchesOf(v, true, nil)
        v.removeGestureRecognizer(p)
    }
}

class PopBackgroundView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow(10, 0.8)
    }
}
