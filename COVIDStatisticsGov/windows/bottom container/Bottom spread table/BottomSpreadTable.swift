//
//  BottomSpreadTable.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 03/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class BottomSpreadTable: UIView {
    
    var tableView: UITableView!
    var containerDelegate: SpreadTableDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init (_ frame: CGRect, _ data: [[String: Any]]) {
        self.init(frame: frame)
        containerDelegate = SpreadTableDelegate(data)
        setup()
    }
    
    func setup() {
        tableView = UITableView()
        tableView.delegate = containerDelegate
        tableView.dataSource = containerDelegate
        tableView.register(SpreadTableCell.self, forCellReuseIdentifier: "spreadCell")
        tableView.register(SpreadTableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorColor = Constants.lightBlueLM
        self.pinView(tableView, UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateConstraints), name: UIDevice.orientationDidChangeNotification, object:  nil)
        
        self.backgroundColor = .clear
        tableView.backgroundColor = .clear
    }
    
    @objc func sendUpdateConstraints() {
        tableView.reloadData()
    }
}

extension BottomSpreadTable : DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.containerDelegate.cellLabelColor = .white
            tableView.separatorColor = .white
        } else {
            self.containerDelegate.cellLabelColor = Constants.darkBlueLM
            tableView.separatorColor = Constants.lightBlueLM
        }
//        self.tableView.reloadData()
    }
}
