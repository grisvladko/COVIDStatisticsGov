//
//  ViewController.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 18/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import Highcharts
import Simctl

class ViewController: UIViewController {
    
    var topContainer: TopContainer = {
        let view = TopContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 2 - 15) * 3.5))
        return view
    }()
    
    var middleContainer: MiddleContainer = {
        return MiddleContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 + 50))
    }()
    
    var bottomContainer: BottomContainer = {
        return BottomContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 7 ))
    }()
    
    var isDarkModeOn = false
    var fixedTopContainerHeight: CGFloat!
    var tableDelegate: MainTableViewDelegate!
    var tableView: MainTableView!
    var navBar: NavigationBar!
    
    var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.BGLM
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchData()
        
        setNavBar()
        setTableView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NotificationCenter.default.post(name: UIDevice.orientationDidChangeNotification, object: nil)
        self.invalidateLayouts()
        
        coordinator.animate(alongsideTransition: { (context) in
            self.updateContainers(size)
        }, completion: { (context) in
            self.tableView.reloadData()
        })
    }
    
    func setNavBar() {
        navBar = NavigationBar(frame: .zero)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            navBar.heightConstraint,
            navBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let g = UITapGestureRecognizer(target: self, action: #selector(menu(_:)))
        navBar.menu.addGestureRecognizer(g)
        
        navBar.darkMode.addTarget(self, action: #selector(darkMode(_:)), for: .touchUpInside)
        self.view.bringSubviewToFront(navBar)
    }
    
    func setTableView() {
        views = [topContainer, middleContainer, bottomContainer]
        tableDelegate = MainTableViewDelegate(views)
        tableView = MainTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.topConstraint = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height / 6)
        
        NSLayoutConstraint.activate([
            tableView.topConstraint,
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
        
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = tableDelegate
        tableView.dataSource = tableDelegate
        
        self.fixedTopContainerHeight = (UIScreen.main.bounds.width / 2 - 15) * 3.5
    }
    
    func getCalculatedFrame(_ viewName: String, _ newSize: CGSize) -> CGRect {
        
        var frame: CGRect!
        
        switch viewName {
        case "top":
            frame = CGRect(x: 0, y: 0, width: newSize.width, height: self.fixedTopContainerHeight)
        case "middle":
            frame = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.width * 3 + 50)
        case "bottom":
            frame = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.width * 7)
        default: break
        }
        
        return frame
    }
    
    func invalidateLayouts() {
        self.topContainer.collectionView.collectionViewLayout.invalidateLayout()
        self.bottomContainer.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func updateContainers(_ size: CGSize) {
        self.tableView.beginUpdates()
        self.topContainer.bounds = self.getCalculatedFrame("top", size)
        self.middleContainer.bounds = self.getCalculatedFrame("middle", size)
        self.bottomContainer.bounds = self.getCalculatedFrame("bottom", size)
        
        self.topContainer.layoutSubviews()
        self.middleContainer.layoutSubviews()
        self.bottomContainer.layoutSubviews()
        
        self.tableDelegate.views = [topContainer, middleContainer, bottomContainer] 
        self.tableView.endUpdates()
    }
    
    @objc func darkMode(_ sender: UIButton) {
        let window = self.view.isVisible(tableView).1 ?? tableView
        
        sender.backgroundColor = isDarkModeOn ? Constants.darkBlueLM : Constants.BGLM
        sender.setTitleColor(isDarkModeOn ? .white : Constants.darkBlueLM, for: .normal)
        sender.setTitle(isDarkModeOn ? navBar.normalTitle : navBar.selectedTitle, for: .normal)
        
        for view in views {
            self.accessSubviewsOf(view)
        }
        
        self.view.backgroundColor = isDarkModeOn ? Constants.BGLM : Constants.BGDM
        isDarkModeOn = !isDarkModeOn
    }
    
    @objc func menu(_ tap: UITapGestureRecognizer) {
    
    }
    
    func accessSubviewsOf(_ view: UIView) {
        
        let subviews = view.subviews
        
        if subviews.count == 0 { return }
        
        for subview in subviews {
            if subview is NavigationBar { continue }
            
            if let label = subview as? UILabel {
                label.textColor = isDarkModeOn ? Constants.darkBlueLM : .white
            } else if let delegate = subview as? DarkModeDelegate {
                delegate.toggleMode(isDarkModeOn)
            }
            
            accessSubviewsOf(subview)
        }
    }
}

extension ViewController : DataDelegate {
    
    func updateData(newData: [[String : Any]]) {
        self.topContainer.containerDelegate.data = newData
        self.middleContainer.containerDelegate.data = newData
        self.bottomContainer.containerDelegate.data = newData

        DispatchQueue.main.async {
            self.topContainer.collectionView.reloadData()
            self.middleContainer.collectionView.reloadData()
            self.bottomContainer.collectionView.reloadData()
        }
    }
}
