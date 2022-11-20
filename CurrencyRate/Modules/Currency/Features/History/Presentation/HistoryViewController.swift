//
//  HistoryViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit
import SwiftCharts

class HistoryViewController: BaseViewController {
    lazy var historyView: HistoryView = {
        return self.baseView as! HistoryView // swiftlint:disable:this force_cast
    }()
    
    lazy var historyViewModel: HistoryViewModel = {
        return self.baseViewModel as!  HistoryViewModel // swiftlint:disable:this force_cast
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyView.historyTableView.delegate = self
        historyView.historyTableView.dataSource = self
        historyViewModel.getHistories()
        historyViewModel.getLatestRates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCharts(isLandScape: false)
    }
    
    override func observeEvents() {
        historyViewModel.histories.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.historyView.historyTableView.reloadData()
        }.disposed(by: historyViewModel.bag)
        
        historyViewModel.latestRates.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.historyView.historyTableView.reloadData()
        }.disposed(by: historyViewModel.bag)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection:
                                           UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        historyView.changeOrientation()
        updateCharts(isLandScape: traitCollection.verticalSizeClass == .compact)
    }
    
    func updateCharts(isLandScape: Bool) {
        historyView.leftView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        let historis = historyViewModel.histories.value
         let bars =  historis.map({("\($0.fromSymbol)", Double(30))})
        let width = isLandScape ? historyView.frame.width * 0.33 : historyView.frame.width
        let height = isLandScape ? historyView.frame.height : historyView.frame.height * 0.34
        let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        let config = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 100, by: 20), xAxisLabelSettings: ChartLabelSettings(fontColor: .red))
        
        let charts = BarsChart(frame: frame,
                               chartConfig: config,
                               xTitle: "Currencies",
                               yTitle: "Search",
                               bars: [("S", 45.5)],
                               color: .darkGray,
                               barWidth: 15)
    
        historyView.leftView.addSubview(charts.view)
    }
}
