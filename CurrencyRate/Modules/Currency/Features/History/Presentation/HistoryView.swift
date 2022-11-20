//
//  HistoryView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit
import Charts

class HistoryView: BaseView {
    lazy var leftView: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightText
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HistoryHeaderView.self,
              forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(HistoryCell.self, forCellReuseIdentifier: String(describing: HistoryCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var landscapeConstraints: [NSLayoutConstraint] = []
    var potraitConstraints: [NSLayoutConstraint] = []
    
    override func create() {
        backgroundColor = .white
        addSubview(leftView)
        addSubview(rightView)
        rightView.addSubview(historyTableView)
        landscapeConstraints = [self.leftView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                                self.leftView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                self.leftView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                                self.leftView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.34),
                                self.rightView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                                self.rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
                                self.rightView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                                self.rightView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)]
        
        potraitConstraints = [self.leftView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                              self.leftView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                              self.leftView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                              self.leftView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.34),
                              self.rightView.topAnchor.constraint(equalTo: leftView.bottomAnchor),
                              self.rightView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                              self.rightView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                              self.rightView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
        
        if traitCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(potraitConstraints)
        }
        
        NSLayoutConstraint.activate([
            self.historyTableView.topAnchor.constraint(equalTo: rightView.topAnchor),
            self.historyTableView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            self.historyTableView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            self.historyTableView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor)
        ])
    }
    
    func changeOrientation() {
        if traitCollection.verticalSizeClass == .compact {
            if let first = potraitConstraints.first {
                if first.isActive {
                    NSLayoutConstraint.deactivate(potraitConstraints)
                    NSLayoutConstraint.activate(landscapeConstraints)
                }
            }
        } else {
            if let first = landscapeConstraints.first {
                if first.isActive {
                    NSLayoutConstraint.deactivate(landscapeConstraints)
                    NSLayoutConstraint.activate(potraitConstraints)
                }
            }
        }
    }
}
