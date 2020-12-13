//
//  MainTableViewDelegate.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit

class MainTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data: Any!
    var views: [UIView]
    
    init(_ views : [UIView]) {
        self.views = views
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        cell.clean()
        cell.setup(views[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        switch indexPath.row {
        case 0: height = views[0].bounds.height
        case 1: height = views[1].bounds.height
        case 2: height = views[2].bounds.height
        default: break
        }
        
        return height
    }
}
