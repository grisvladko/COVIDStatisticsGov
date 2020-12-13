//
//  ConfirmedSickCellContentView.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 15/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class ConfirmedSickCellContentView: UIView, PopViewDelegateProtocol {
    
    let l1 = UILabel(frame: .zero)
    let l2 = UILabel(frame: .zero)
    let l3 = UILabel(frame: .zero)
    let l4 = UILabel(frame: .zero)
    let l5 = UILabel(frame: .zero)
    let l6 = UILabel(frame: .zero)
    let infoButton = UIButton(type: .infoLight)
    let infoLabelDescription =
    """
    סך הנדבקים בנגיף COVID-19 בישראל שאותרו משעה 00:00 עד שעה 23:59 של יום אתמול

    מאומת - כל מי שנבדק ונמצא חיובי לנגיף COVID-19, בין אם הופיעו אצלו תסמינים ובין אם לא, בין או הוא חולה, החלים או נפטר
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
        
        let items = [l1,l2,l3,l4,l5,l6,infoButton]
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        }
        
        setItems()
        setConstraints()
    }
 
    func setItems() {
        let bigFontSize = self.bounds.height / 9
        l1.setLabel(bigFontSize, "מאומתים חדשים אתמול", true)
        l1.numberOfLines = 0
        l1.lineBreakMode = .byWordWrapping
        l2.setLabel(bigFontSize, "0", true)
        l3.setLabel(12, "0", true)
        l4.setLabel(12, "מחצות", false)
        l5.setLabel(12, "0", true)
        l6.setLabel(12, "סה״כ", false)
        infoButton.setButton(.gray, .white)
        infoButton.addTarget(self, action: #selector(popInfoLabel), for: .touchUpInside)
    }
    
    @objc func popInfoLabel() {
        popDelegate!.popInfoLabel(self, infoButton, infoLabelDescription)
    }

    
    func setConstraints() {
        NSLayoutConstraint.activate([
            l1.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            l1.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            l1.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: infoButton.bounds.width + 10),
            l2.topAnchor.constraint(equalTo: l1.bottomAnchor,constant: 5),
            l2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            l2.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor),
            l3.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            l4.topAnchor.constraint(equalTo: l2.bottomAnchor, constant: 5),
            l4.trailingAnchor.constraint(equalTo: l3.leadingAnchor, constant: -5),
            l5.topAnchor.constraint(equalTo: l3.bottomAnchor, constant: 5),
            l5.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            l6.topAnchor.constraint(equalTo: l3.bottomAnchor, constant: 5),
            l6.trailingAnchor.constraint(equalTo: l5.leadingAnchor, constant: -5),
            infoButton.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 10),
            infoButton.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10)
        ])
    }
}

extension ConfirmedSickCellContentView: DataSetupDelegate {
    
    func setupWithData(_ data: [[String : Any]]) {
        for dict in data {
            if dict[Constants.Keys.newCases] != nil {
                l2.text = "\(dict[Constants.Keys.newCases]!)"
                l3.text = "\(dict[Constants.Keys.newCases]!)"
                l5.text = "\(dict[Constants.Keys.newCases]!)"
                return
            }
        }
    }
}

extension ConfirmedSickCellContentView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            infoButton.setButton(.white, Constants.cellBGDM)
        } else {
            infoButton.setButton(.gray, .white)
        }
    }
}
