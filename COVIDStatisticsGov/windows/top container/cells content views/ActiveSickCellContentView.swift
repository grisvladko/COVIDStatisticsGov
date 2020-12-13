//
//  ActiveSickCellContentView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 15/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class ActiveSickCellContentView: UIView, PopViewDelegateProtocol {
    
    let l1 = UILabel(frame: .zero)
    let l2 = UILabel(frame: .zero)
    let l3 = UILabel(frame: .zero)
    let l4 = UILabel(frame: .zero)
    let l5 = UILabel(frame: .zero)
    let l6 = UILabel(frame: .zero)
    let l7 = UILabel(frame: .zero)
    let l8 = UILabel(frame: .zero)
    let l9 = UILabel(frame: .zero)
    let l10 = UILabel(frame: .zero)
    let infoButton = UIButton(type: .infoLight)
    let infoLabelDescription =
    """
    חולה פעיל - כל מי שנבדק חיובי לנגיף COVID-19, ללא קשר להופעת תסמינים שטרם הוגדר כמחלים ולא נמוג
    """
    
    var popDelegate: PopViewDelegate?
    
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
        setConstraints()
    }
    
    func setItems() {
        let bigFontSize = self.bounds.height / 9
        l1.setLabel(bigFontSize, "חולים פעילים", true)
        l2.setLabel(bigFontSize, "0", true)
        l3.setLabel(12, "0", true)
        l4.setLabel(12, "מחצות", false)
        
        l5.setLabel(12, "בי״ח", false)
        l6.setLabel(12, "מלון", false)
        l7.setLabel(12, "ביתֿ / קהילה", false)
        l8.setLabel(12, "0", true)
        l9.setLabel(12, "0", true)
        l10.setLabel(12, "0", true)
        
        infoButton.setButton(.gray, .white)
        infoButton.addTarget(self, action: #selector(popInfoLabel), for: .touchUpInside)
        makeBottom()
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
            l3.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            l4.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l4.trailingAnchor.constraint(equalTo: l3.leadingAnchor, constant: -5),
            infoButton.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 10),
            infoButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10)
        ])
    }
    
    func makeBottom() {
        let l5l8Stack = makeStackView([l5,l8], .vertical, 5, .center, .fill)
        let l6l9Stack = makeStackView([l6,l9], .vertical, 5, .center, .fill)
        let l7l10Stack = makeStackView([l7,l10], .vertical, 5, .center, .fill)
        
        let bottomStackView = makeStackView([l7l10Stack,l6l9Stack,l5l8Stack], .horizontal, 10, .fill, .fill)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            bottomStackView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10)
        ])
    }
}

extension ActiveSickCellContentView: DataSetupDelegate {
    
    func setupWithData(_ data: [[String : Any]]) {
        for dict in data {
            if dict[Constants.Keys.totalTested] != nil {
                l2.text = "\(dict[Constants.Keys.totalTested]!)"
                l3.text = "\(dict[Constants.Keys.totalTested]!)"
                l8.text = "\(dict[Constants.Keys.totalTested]!)"
                l9.text = "\(dict[Constants.Keys.totalTested]!)"
                l10.text = "\(dict[Constants.Keys.totalTested]!)"
                return
            }
        }
    }
}

extension ActiveSickCellContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            infoButton.setButton(.white, Constants.cellBGDM)
        } else {
            infoButton.setButton(.gray, .white)
        }
    }
}
