//
//  File.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 21/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(_ radius: CGFloat, _ opacity: Float) {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
    }

    
    func isVisible(_ view: UIView) -> (Bool, UIView?) {
        func isVisible(_ view: UIView, inView: UIView?) -> (Bool, UIView?){
            let viewFrame = inView!.convert(view.bounds, from: view)
            if viewFrame.intersects(inView!.bounds) {
                if inView?.superview == nil {
                    return (true, inView)
                }
                return isVisible(view, inView: inView!.superview)
            }
            return (false, nil)
        }
        return isVisible(view, inView: view.superview)
    }
    
    func pinView(_ view: UIView,_ constants: UIEdgeInsets) {
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: constants.top).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constants.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constants.left).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constants.right).isActive = true
    }
    
    //title and colors should always have same length
    func makeLegendStackView(_ titles: [String], _ colors: [UIColor], _ spacing: CGFloat, _ height: CGFloat) -> UIStackView{
        
        var labels = [UILabel]()
        
        for i in 0..<titles.count {
            let label = UILabel()
            label.text = titles[i]
            
            let size = titles[i].size(withAttributes: [.font : UIFont.systemFont(ofSize: 15)])
            let point = CGPoint(x: size.width, y: size.height / 4)
            
            let circle = CAShapeLayer()
            let path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: height, height: height), cornerRadius: height / 2)
            
            circle.path = path.cgPath
            circle.fillColor = colors[i].cgColor
            label.textAlignment = .right
            label.font = label.font.withSize(14)
            label.textColor = Constants.darkBlueLM
            label.layer.addSublayer(circle)
            label.translatesAutoresizingMaskIntoConstraints = false
            labels.append(label)
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = spacing
        
        return stackView
    }
    
    func makeHamburgerMenu(_ width: CGFloat, _ height: CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        let paths = [UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: 1)),UIBezierPath(rect: CGRect(x: 0, y: (height / 3) * 1, width: width, height: 1)),UIBezierPath(rect: CGRect(x: 0, y: (height / 3) * 2, width: width, height: 1))]
        
        for i in 0..<paths.count {
            let layer = CAShapeLayer()
            layer.path = paths[i].cgPath
            layer.strokeColor = Constants.darkBlueLM.cgColor
            view.layer.addSublayer(layer)
        }
        
        return view
    }
    
    //make weird results on resizing
    func roundCorners(_ corners: CACornerMask, _ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    
    func makeStackView(_ views: [UIView], _ axis: NSLayoutConstraint.Axis, _ spacing: CGFloat, _ alignment: UIStackView.Alignment, _ distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.axis = axis
        stackView.spacing = spacing
        
        return stackView
    }
}

extension UILabel {
    func setLabel(_ fontSize: CGFloat, _ text: String, _ isBold: Bool) {
        self.textAlignment = .right
        self.text = text
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize:fontSize)
        } else {
            self.font = self.font.withSize(fontSize)
        }
        self.textColor = Constants.darkBlueLM
        self.adjustsFontSizeToFitWidth = true
    }
    
    func makeLabelWithCircle(_ color: UIColor, _ height: CGFloat, _ ofFontSize: CGFloat) {
        guard text != nil else { return }
        
        let size = text!.size(withAttributes: [.font : UIFont.systemFont(ofSize: ofFontSize )])
        let point = CGPoint(x: size.width, y: size.height / 4)
        
        let circle = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: height, height: height), cornerRadius: height / 2)
        
        circle.path = path.cgPath
        circle.fillColor = color.cgColor
        self.layer.addSublayer(circle)
    }
}

extension UICollectionViewCell {
    func clean() {
        for subview in self.subviews {
            if subview === self.contentView { continue }
            subview.removeFromSuperview()
        }
    }
}

extension UITableViewCell {
    func clean() {
        for subview in self.subviews {
            if subview === self.contentView { continue }
            subview.removeFromSuperview()
        }
    }
}

extension UIButton {
    func setButton(_ bgColor: UIColor, _ tintColor: UIColor) {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = bgColor
        self.tintColor = tintColor
    }
}


