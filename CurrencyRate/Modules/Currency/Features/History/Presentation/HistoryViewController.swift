//
//  HistoryViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit
import Charts

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
        updateCharts()
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
    }
    
    func updateCharts() {
        if historyViewModel.histories.value.isEmpty {
            return
        }
        var chartValues: [String: Int] = [:]
        
        historyViewModel.histories.value.forEach { history in
            if let dateOnly = history.createdAt.toString(isDateOnly: true) {
               let currenctCount = chartValues[dateOnly] ?? 0
                chartValues[dateOnly] = currenctCount + 1
            }
        }
        
        var dataSets = [BarChartDataSet]()
        
        var index = 0
        chartValues.forEach { key, value in
            let value = BarChartDataEntry(x: Double(index), y: Double(value))
            let set1 = BarChartDataSet(entries: [value], label: key)
            set1.colors = [ChartColorTemplates.colorful()[index]]
            set1.drawValuesEnabled = false
            dataSets.append(set1)
            index += 1
        }
        
        let data = BarChartData(dataSets: dataSets)
        
        historyView.leftView.data = data
    }
}
