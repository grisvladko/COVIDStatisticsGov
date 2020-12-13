//
//  BottomHospitalStatusTable.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 03/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class BottomHospitalStatusTable: UIView {

    var tableView: UITableView!
    var containerDelegate: HospitalStatusDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(_ frame: CGRect, _ data: [[String: Any]]) {
        self.init(frame: frame)
        containerDelegate = HospitalStatusDelegate(data)
        setup()
    }
    
    func setup() {
        tableView = UITableView()
        tableView.dataSource = containerDelegate
        tableView.delegate = containerDelegate
        tableView.register(HospitalStatusCell.self, forCellReuseIdentifier: "hospitalCell")
        tableView.register(HospitalStatusHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorColor = Constants.lightBlueLM
        self.pinView(tableView, .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateConstraints), name: UIDevice.orientationDidChangeNotification, object:  nil)
        
        self.backgroundColor = .clear
        tableView.backgroundColor = .clear
    }
    
    @objc func sendUpdateConstraints() {
        tableView.reloadData()
    }
}

extension BottomHospitalStatusTable: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.containerDelegate.cellLabelColor = .white
            tableView.separatorColor = .white
        } else {
            self.containerDelegate.cellLabelColor = Constants.darkBlueLM
            tableView.separatorColor = Constants.lightBlueLM
        }
    }
}
