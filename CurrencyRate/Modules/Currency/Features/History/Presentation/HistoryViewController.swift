//
//  HistoryViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

class HistoryViewController: BaseViewController {
    private lazy var historyView: HistoryView = {
        return self.baseView as! HistoryView // swiftlint:disable:this force_cast
    }()
    
    lazy var historyViewModel: HistoryViewModel = {
        return self.baseViewModel as!  HistoryViewModel // swiftlint:disable:this force_cast
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func observeEvents() {
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection:
                                           UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        historyView.changeOrientation()
    }
}
