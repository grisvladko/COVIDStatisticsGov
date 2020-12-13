//
//  HeavilySickCellContentView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 15/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class HeavilySickCellContentView: UIView, PopViewDelegateProtocol {

    let l1 = UILabel(frame: .zero)
    let l2 = UILabel(frame: .zero)
    let l3 = UILabel(frame: .zero)
    let l4 = UILabel(frame: .zero)
    let l5 = UILabel(frame: .zero)
    let l6 = UILabel(frame: .zero)
    let l7 = UILabel(frame: .zero)
    let l8 = UILabel(frame: .zero)
    let infoButton = UIButton(type: .infoLight)
    let infoLabelDescription =
    """
    סך החולים במצב קשה וקריטי כפי שהוגדרו ע״י מערכת הבריאות, המאושפזים בבתי החולים
    """
    
    var popDelegate: PopViewDelegate?
    var criticalStackview: UIStackView!
    var avarageStackview: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setIndexPath(_ indexPath: IndexPath) {
        popDelegate = PopViewDelegate(indexPath, nil)
    }
    
    func setup() {
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .clear
        
        let items = [l1,l2,l3,l4,infoButton]
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        
        setItems()
        setLegend()
        setConstraints()
    }
    
    func setItems() {
        let bigFontSize = self.bounds.height / 9
        l1.setLabel(bigFontSize, "חולים קשה", true)
        l2.setLabel(bigFontSize, "0", true)
        l3.setLabel(12, "0", true)
        l4.setLabel(12, "מחצות", false)
        infoButton.setButton(.gray, .white)
        infoButton.addTarget(self, action: #selector(popInfoLabel), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(test), for: .touchUpOutside)
    }
    
    func setLegend() {
        l5.setLabel(12, "מתוכם קריטי", false)
        l5.makeLabelWithCircle(Constants.redLegend, 8, 13)
        l7.setLabel(12, "0", true)
        criticalStackview = makeStackView([l7,l5], .horizontal, 10, .fill, .fill)
        criticalStackview.translatesAutoresizingMaskIntoConstraints = false
        
        l6.setLabel(12, "בינוני", false)
        l6.makeLabelWithCircle(Constants.yellowLegend, 8, 14)
        l8.setLabel(12, "0", true)
        avarageStackview = makeStackView([l8,l6], .horizontal, 10, .fill, .fill)
        avarageStackview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(criticalStackview)
        self.addSubview(avarageStackview)
    }
    
    @objc func popInfoLabel() {
        popDelegate!.popInfoLabel(self, infoButton, infoLabelDescription)
    }

    
    func setConstraints() {
        NSLayoutConstraint.activate([
            l1.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            l1.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l1.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: infoButton.bounds.width + 10),
            l2.topAnchor.constraint(equalTo: l1.bottomAnchor,constant: 5),
            l2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l2.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor),
            l3.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            l4.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l4.trailingAnchor.constraint(equalTo: l3.leadingAnchor, constant: -5),
            infoButton.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 10),
            infoButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            criticalStackview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            criticalStackview.bottomAnchor.constraint(equalTo: avarageStackview.topAnchor, constant: -5),
            avarageStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            avarageStackview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
}

extension HeavilySickCellContentView: DataSetupDelegate {
    
    func setupWithData(_ data: [[String : Any]]) {
        
        for dict in data {
            if dict[Constants.Keys.totalCases] != nil {
                l2.text = "\(dict[Constants.Keys.totalCases]!)"
                l3.text = "\(dict[Constants.Keys.totalCases]!)"
                l8.text = "\(dict[Constants.Keys.totalCases]!)"
                l7.text = "\(dict[Constants.Keys.totalCases]!)"
                return
            }
        }
    }
}

extension HeavilySickCellContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            infoButton.setButton(.white, Constants.cellBGDM)
        } else {
            infoButton.setButton(.gray, .white)
        }
    }
}
