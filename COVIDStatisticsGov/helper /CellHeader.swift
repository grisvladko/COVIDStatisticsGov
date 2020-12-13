//
//  CellHeader.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 21/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class CellHeader: UIView {
    
    enum Options {
        case all
        case titleOnly
        case titleAndInfo
        case titleAndChevron
    }
    
    var delegate: ChartDataUpdateDelegate?
    var popChevronOptions: PopBackgroundView?
    var infoTitle: String?
    var infoIcon: FontAwesome?
    var infoView: InfoView?
    var option: Options?
    var chevronOption: ChevronView.Options?
    var chevronView: ChevronView?
    var topStackView: UIStackView?
    var titleText: String?
    var isDarkModeOn: Bool?
    
    let titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ frame: CGRect, _ option: Options, _ titleText: String, _ infoTitle: String, _ infoIcon: FontAwesome) {
        self.init(frame: frame)
        self.option = option
        self.titleText = titleText
        self.infoTitle = infoTitle
        self.infoIcon = infoIcon
        setup()
    }
    
    convenience init (_ frame: CGRect, _ option: Options, _ titleText: String) {
        self.init(frame: frame)
        self.titleText = titleText
        self.option = option
        setup()
    }
    
    convenience init(_ frame: CGRect, _ option: Options, _ titleText: String, _ infoTitle: String?, _ infoIcon: FontAwesome?, _ chevronOption: ChevronView.Options) {
        self.init(frame: frame)
        self.option = option
        self.titleText = titleText
        self.infoTitle = infoTitle
        self.infoIcon = infoIcon
        self.chevronOption = chevronOption
        setup()
    }
    
    func setup() {
        let bigFontSize = UIScreen.main.bounds.width / 22
        titleLabel.setLabel(bigFontSize, titleText!, true)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        self.addSubview(titleLabel)
        setConstraintsForOptions(self.option!)
    }
    
    func setConstraintsForOptions(_ option: Options) {
        switch option {
            case .all: setupAll()
            case .titleAndInfo : setupTitleAndInfo()
            case .titleOnly: setConstraintsForTopComponent(titleLabel)
            case .titleAndChevron: setupTitleAndChevron()
        }
    }
    
    func setupAll() {
        setupTopStackView()
        setupInfoView()
        setConstraintsForTopComponent(topStackView!)
        setConstraintsForInfoComponent(infoView!, topStackView!)
    }
    
    func setupTitleAndInfo() {
        setupInfoView()
        setConstraintsForTopComponent(titleLabel)
        setConstraintsForInfoComponent(infoView!, titleLabel)
    }
    
    func setupTitleAndChevron() {
        setupTopStackView()
        setConstraintsForTopComponent(topStackView!)
    }
    
    func setConstraintsForInfoComponent(_ component: UIView, _ topComponent: UIView) {
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: topComponent.bottomAnchor, constant: 5),
            component.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            component.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            component.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])
    }
    
    func setConstraintsForTopComponent(_ component: UIView) {
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            component.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            component.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
    }
    
    func setupTopStackView() {
        setupChevronView()
        topStackView = makeStackView([chevronView!,titleLabel], .horizontal, 20, .center, .fillProportionally)
        topStackView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topStackView!)
    }
    
    func setupInfoView() {
        if infoTitle == nil || infoIcon == nil { return }
        
        infoView = InfoView(.zero, infoTitle!, infoIcon!)
        infoView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(infoView!)
    }
    
    func setupChevronView() {
        guard self.chevronOption != nil else { return }
        chevronView = ChevronView(.zero, chevronOption!)
        chevronView!.translatesAutoresizingMaskIntoConstraints = false
        chevronView!.widthAnchor.constraint(equalToConstant: 130).isActive = true
        chevronView!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        chevronView!.setNeedsLayout()
        chevronView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chevronTap)))
    }
    
    @objc func chevronTap() {
        chevronView!.rotateChevron()
        openChevronOptions()
    }
    
    func openChevronOptions() {
        guard let mainView = self.isVisible(chevronView!).1 else { return }
        guard self.chevronOption != nil  else { return }
        
        let point = chevronView!.convert(chevronView!.center, to: mainView)
        
        var buttons: [UIButton] = []
        print(chevronOption!)
        let titles = chevronOption! == .sickSituation ? chevronView!.sickSituationTitles : chevronView!.timeLineTitles
        
        var titleColor = Constants.darkBlueLM
        if isDarkModeOn != nil {
            titleColor = !isDarkModeOn! ? .white : titleColor
        }
        
        for i in 0..<titles.count {
            let button = UIButton()
            button.setTitle(titles[i], for: .normal)
            button.backgroundColor = chevronView!.backgroundColor
            button.layer.borderWidth = 1
            button.layer.borderColor = Constants.infoBG.cgColor
            button.tag = i
            button.addTarget(self, action: #selector(selectedChevronOption(_:)), for: .touchUpInside)
            button.setTitleColor(titleColor, for: .normal)
            buttons.append(button)
        }
        
        let stackView = makeStackView(buttons, .vertical, 0, .fill, .fill)
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.popChevronOptions = PopBackgroundView()
        self.popChevronOptions!.translatesAutoresizingMaskIntoConstraints = false
        self.popChevronOptions!.addShadow(10, 0.8)
        self.popChevronOptions!.pinView(stackView, .zero)
        
        mainView.addSubview(self.popChevronOptions!)
        
        let dimention: CGFloat = 130
                
        if point.y < mainView.center.y + dimention {
            self.popChevronOptions!.topAnchor.constraint(equalTo: chevronView!.bottomAnchor, constant: 10).isActive = true
        } else {
            self.popChevronOptions!.bottomAnchor.constraint(equalTo: chevronView!.topAnchor, constant: -10).isActive = true
        }
        self.popChevronOptions!.centerXAnchor.constraint(equalTo: chevronView!.centerXAnchor).isActive = true
        self.popChevronOptions!.widthAnchor.constraint(equalToConstant: dimention).isActive = true
        
        let remove = UITapGestureRecognizer(target: self, action: #selector(remove(_:)))
        allowsSubviewTouchesOf(mainView, false, [self.popChevronOptions!])
        mainView.addGestureRecognizer(remove)
    }
    
    @objc func remove(_ p: UITapGestureRecognizer) {
        if popChevronOptions != nil {
            removeChevronOptions()
        }
        
        guard let v = p.view else { return }
        allowsSubviewTouchesOf(v, true, nil)
        v.removeGestureRecognizer(p)
    }
    
    func removeChevronOptions() {
        self.chevronView!.rotateChevron()
        guard self.popChevronOptions != nil else { return }
        self.popChevronOptions!.removeShadow()
        self.popChevronOptions!.removeFromSuperview()
        self.popChevronOptions = nil
    }
    
    @objc func selectedChevronOption(_ sender: UIButton) {
        guard let mainView = self.popChevronOptions!.superview else { return }
        allowsSubviewTouchesOf(mainView, true, nil)
        removeChevronOptions()
        self.chevronView!.changeTitle(sender.tag)
        let option = self.chevronView!.getOptionForChartUpdate()
        self.delegate!.updateChart(option)
    }
    
    func allowsSubviewTouchesOf(_ view: UIView, _ isAllowed: Bool, _ allowedViews: [UIView]?) {
        for subview in view.subviews {
            if allowedViews != nil {
                if allowedViews!.contains(subview) {
                    continue
                }
            }
            subview.isUserInteractionEnabled = isAllowed
        }
    }
}

extension CellHeader: DarkModeDelegate {
    
    func toggleMode(_ isDarkModeOn: Bool) {
        self.isDarkModeOn = isDarkModeOn
    }
}

class InfoView: UIView {
    
    var title: String?
    var info = UILabel()
    var attribute: FontAwesome?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ frame: CGRect, _ title: String, _ attribute: FontAwesome) {
        self.init(frame: frame)
        self.title = title
        self.attribute = attribute
        setup()
    }
    
    func setup() {
        self.backgroundColor = Constants.infoBG
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        guard self.title != nil else { return }
        
        let label = UILabel(frame: .zero)
        label.setLabel(12, title!, false )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        info.translatesAutoresizingMaskIntoConstraints = false
        info.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
        info.text = String.fontAwesomeIcon(name: attribute!)
        
        self.addSubview(label)
        self.addSubview(info)

        NSLayoutConstraint.activate([
            info.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            info.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.rightAnchor.constraint(equalTo: info.leftAnchor, constant: -5),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10)
        ])
    }
}

extension InfoView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.backgroundColor = Constants.darkBlueLM
            info.textColor = .white
        } else {
            self.backgroundColor = Constants.infoBG
            info.textColor = Constants.darkBlueLM
        }
    }
}

class ChevronView: UIView {
    
    enum Options {
        case timeLine
        case sickSituation
    }
    
    let timeLineTitles = ["עד עכשיו","שבוע אחרון","שבועיים אחרונים","חודש אחרון"]
    let sickSituationTitles = ["מאומתים","נפטרים","מונשמים","מצב קשה"]
    
    var option: Options?
    var chevronLabel = UILabel(frame: .zero)
    var titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ frame: CGRect, _ option: Options) {
        self.init(frame: frame)
        self.option = option
        setup()
    }
    
    func setup() {
        let title = option! == .sickSituation ? sickSituationTitles[0] : timeLineTitles[0]
        
        self.backgroundColor = Constants.infoBG
        
        chevronLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronLabel.font = UIFont.fontAwesome(ofSize: 14, style: .solid)
        chevronLabel.text = String.fontAwesomeIcon(name: .chevronUp)
        self.addSubview(chevronLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setLabel(14, title, true)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            chevronLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            chevronLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.layer.cornerRadius = 25 / 2
        self.layer.masksToBounds = true
    }
    
    func rotateChevron() {
        self.chevronLabel.transform = self.chevronLabel.transform.rotated(by: .pi)
    }
    
    func changeTitle(_ index: Int) {
        guard self.option != nil else { return }
        switch self.option! {
        case .timeLine: self.titleLabel.text = timeLineTitles[index]
        case .sickSituation: self.titleLabel.text = sickSituationTitles[index]
        }
    }
    
    func getOptionForChartUpdate() -> ChartsInitializer.Options {
        guard titleLabel.text != nil else { return .all}
        switch titleLabel.text! {
        case "חודש אחרון": return .month
        case "שבוע אחרון": return .week
        case "שבועיים אחרונים": return .biWeek
        case "עד עכשיו": return .all
        case "מאומתים": return .confirmed
        case "נפטרים": return .deprecated
        case "מונשמים": return .respiratory
        case "מצב קשה": return .heavilySick
        default: break
        }
        return .all
    }
}

extension ChevronView: DarkModeDelegate {
    func toggleMode(_ isDarkModeOn: Bool) {
        if !isDarkModeOn {
            self.backgroundColor = Constants.darkBlueLM
            self.layer.borderColor = Constants.infoBG.cgColor
        } else {
            self.backgroundColor = Constants.infoBG
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
}
