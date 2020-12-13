//
//  NavigationBar.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 19/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    
    var darkMode: UIButton!
    var menu: UIView!
    var imv: UIImageView!
    var stackView: UIStackView!
    
    var heightConstraint: NSLayoutConstraint!
    var rightConstraintForTextStackViewLandscape: NSLayoutConstraint!
    var rightConstraintForTextStackViewDefault: NSLayoutConstraint!
    var leftConstraintForTextStackView: NSLayoutConstraint!
    
    var selectedTitle = "לתצוגה רגילה"
    var normalTitle = "לתצוגה נגישה"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let img = UIImage(named: "health", in: Bundle.main, compatibleWith: nil)
        
        imv = UIImageView(image: img)
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFit
        imv.clipsToBounds = true

        menu = makeHamburgerMenu(25, 25)
        menu.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(menu)
        self.addSubview(imv)
        self.backgroundColor = .white
        
        darkMode = UIButton()
        darkMode.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(darkMode)
        
        darkMode.backgroundColor = Constants.darkBlueLM
        darkMode.titleEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 7, right: 10)
        darkMode.tintColor = .white
        darkMode.titleLabel?.adjustsFontSizeToFitWidth = true
        darkMode.setTitle(normalTitle, for: .normal)
        darkMode.layer.masksToBounds = true
        darkMode.layer.cornerRadius = 20 / 2
        
        let imvHeight = (UIScreen.main.bounds.height / 6) * 0.45
        let imvWidth = UIScreen.main.bounds.width * 0.65
        
        let label = UILabel(frame: .zero)
        label.text = "נגיף הקורונה בישראל - תמונת מצב כללית"
        label.textColor = Constants.darkBlueLM
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.adjustsFontSizeToFitWidth = true
        
        let label2 = UILabel(frame: .zero)
        label2.text = "עדכון אחרון: 6 בנובמבר 2020 | 09:17"
        label2.textColor = Constants.darkBlueLM
        label2.font = label2.font.withSize(10)
        label2.adjustsFontSizeToFitWidth = true
        
        stackView = UIStackView(arrangedSubviews: [label,label2])
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 1
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6)
        self.rightConstraintForTextStackViewDefault = stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -15)
        self.rightConstraintForTextStackViewLandscape = stackView.rightAnchor.constraint(lessThanOrEqualTo: imv.leftAnchor)
        self.leftConstraintForTextStackView = stackView.leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: darkMode.rightAnchor, multiplier: 1)
        
        let constraints = [
            darkMode.heightAnchor.constraint(equalToConstant: 20),
            darkMode.widthAnchor.constraint(equalToConstant: 100),
            darkMode.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
            darkMode.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            menu.heightAnchor.constraint(equalToConstant: 25),
            menu.widthAnchor.constraint(equalToConstant: 25),
            menu.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menu.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -15),
            imv.rightAnchor.constraint(equalTo: menu.leftAnchor, constant: -10),
            imv.heightAnchor.constraint(equalToConstant: imvHeight),
            imv.widthAnchor.constraint(equalToConstant: imvWidth),
            imv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            self.leftConstraintForTextStackView!,
            self.rightConstraintForTextStackViewDefault!
        ]
        
        listenToUpdateConstraints()
        
        NSLayoutConstraint.activate(constraints)
        
        //add gradiend shadow here
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height:10)
    }
    
    func listenToUpdateConstraints() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateConstraints), name: UIDevice.orientationDidChangeNotification, object:  nil)
    }
 
    
    @objc func sendUpdateConstraints() {
        self.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            self.rightConstraintForTextStackViewDefault.isActive = false
            self.rightConstraintForTextStackViewLandscape.isActive = true
        case .landscapeRight:
            self.rightConstraintForTextStackViewDefault.isActive = false
            self.rightConstraintForTextStackViewLandscape.isActive = true
        default:
            self.rightConstraintForTextStackViewDefault.isActive = true
            self.rightConstraintForTextStackViewLandscape.isActive = false
        }
        
        self.heightConstraint.constant = UIScreen.main.bounds.height / 6
    }
}
