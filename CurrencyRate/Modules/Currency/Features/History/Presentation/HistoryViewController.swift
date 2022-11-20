//
//  HistoryViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

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
}
