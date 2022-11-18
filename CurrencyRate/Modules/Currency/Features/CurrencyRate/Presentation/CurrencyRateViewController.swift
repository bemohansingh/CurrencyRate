//
//  CurrencyRateViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class CurrencyRateViewController: BaseViewController {
    private lazy var currencyRateView: CurrencyRateView = {
        return self.baseView as! CurrencyRateView // swiftlint:disable:this force_cast
    }()
    
    private lazy var currencyRateViewModel: CurrencyRateViewModel = {
        return self.baseViewModel as!  CurrencyRateViewModel // swiftlint:disable:this force_cast
    }()
    
    private let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        currencyRateView.fromTextField.inputView = picker
        currencyRateView.toTextField.inputView = picker
        
        currencyRateView.fromTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(fromDoneTapped))
        currencyRateView.toTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(toDoneTapped))
        
        currencyRateView.detailCurrencyButton.addTarget(self, action: #selector(gotoDetailView), for: .touchUpInside)
        currencyRateView.switchCurrencyButton.addTarget(self, action: #selector(switchCurrencyTapped), for: .touchUpInside)
    }
    
    override func observeEvents() {
        currencyRateViewModel.hideCurrencyInput.bind(to: currencyRateView.inputCurrencyTextField.rx.isHidden).disposed(by: currencyRateViewModel.bag)
        currencyRateViewModel.hideCurrencyInput.bind(to: currencyRateView.outputCurrencyTextField.rx.isHidden).disposed(by: currencyRateViewModel.bag)
        
        currencyRateViewModel.fromCurrency.bind(to: currencyRateView.fromTextField.rx.text).disposed(by: currencyRateViewModel.bag)
        currencyRateViewModel.toCurrency.bind(to: currencyRateView.toTextField.rx.text).disposed(by: currencyRateViewModel.bag)
        
        currencyRateViewModel.hideCurrencyInput.map({!$0}).bind(to: currencyRateView.switchCurrencyButton.rx.isEnabled).disposed(by: currencyRateViewModel.bag)
    }
    
    @objc func fromDoneTapped(_ sender: Any) {
        currencyRateViewModel.fromCurrency.accept("\(picker.selectedRow(inComponent: 0))")
    }
    
    @objc func toDoneTapped(_ sender: Any) {
        currencyRateViewModel.toCurrency.accept("\(picker.selectedRow(inComponent: 0))")
    }
    
    @objc func gotoDetailView() {
        
    }
    
    @objc func switchCurrencyTapped() {
        currencyRateViewModel.switchCurrency()
    }
}
