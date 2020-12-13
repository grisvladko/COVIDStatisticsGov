//
//  PassedAwayContentView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 19/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class PassedAwayContentView: UIView, PopViewDelegateProtocol {

    let l1 = UILabel(frame: .zero)
    let l2 = UILabel(frame: .zero)
    let l5 = UILabel(frame: .zero)
    let openChart = PopUpButton(frame: .zero)
    let infoButton = UIButton(type: .infoLight)
    let infoLabelDescription =
    """
    סך הנפטרים מנגיף COVID-19 בישראל, החל מפרוץ המגפה
    """
    
    var popDelegate: PopViewDelegate?
    var buttonStackView: UIStackView!
    var chartData: [[String: Any]]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        guard self.chartData != nil else { return }
        self.popDelegate = PopViewDelegate(indexPath, chartData!)
    }
    
    func setup() {
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .clear
        
        let items = [l1,l2,infoButton]
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        
        setItems()
        setConstraints()
    
    }
    
    func setItems() {
        let bigFontSize = self.bounds.height / 9
        l1.setLabel(bigFontSize, "נפטרים מצטבר", true)
        l2.setLabel(bigFontSize, "0", true)
        l5.setLabel(16, "מגמת שינוי יומית", false)
        infoButton.setButton(.gray, .white)
        
        buttonStackView = self.makeStackView([l5, openChart], .horizontal, 10, .fill, .fill)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStackView)
        
        infoButton.addTarget(self, action: #selector(popInfoLabel), for: .touchUpInside)
        openChart.addTarget(self, action: #selector(popChart), for: .touchUpInside)
    }
    
    @objc func popChart() {
        popDelegate?.popView(self, l5.text! ,openChart, self.chartData!)
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
            l2.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            openChart.heightAnchor.constraint(equalToConstant: 30),
            openChart.widthAnchor.constraint(equalToConstant: 30),
            buttonStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            buttonStackView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            infoButton.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 10),
            infoButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10)
        ])
    }

}

extension PassedAwayContentView: DataSetupDelegate {
    
    func setupWithData(_ data: [[String : Any]]) {
        self.chartData = data
        for dict in data {
            if dict[Constants.Keys.totalCases] != nil {
                l2.text = "\(dict[Constants.Keys.totalCases]!)"
                return
            }
        }
    }
}

extension PassedAwayContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            infoButton.setButton(.white, Constants.cellBGDM)
        } else {
            infoButton.setButton(.gray, .white)
        }
        openChart.wasSelected = !isDarkModeOn
    }
}
