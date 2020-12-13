//
//  SpreadTableDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class SpreadTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let data: [[String: Any]]
    var cellLabelColor: UIColor?
    
    init(_ data: [[String: Any]]) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spreadCell", for: indexPath) as! SpreadTableCell
        
        if cellLabelColor != nil { cell.labelColor = cellLabelColor! }
        
        cell.backgroundColor = .clear
        cell.setup(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! SpreadTableHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
