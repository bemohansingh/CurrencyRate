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
    
    lazy var currencyRateViewModel: CurrencyRateViewModel = {
        return self.baseViewModel as!  CurrencyRateViewModel // swiftlint:disable:this force_cast
    }()
    
    private let picker = UIPickerView()
    private var requestedTextField: RequestTextField = .nothing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        currencyRateView.fromTextField.inputView = picker
        currencyRateView.toTextField.inputView = picker
        
        currencyRateView.fromTextField.delegate = self
        currencyRateView.toTextField.delegate = self
        currencyRateView.fromTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(fromDoneTapped))
        currencyRateView.toTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(toDoneTapped))
        
        currencyRateView.detailCurrencyButton.addTarget(self, action: #selector(gotoDetailView), for: .touchUpInside)
        currencyRateView.switchCurrencyButton.addTarget(self, action: #selector(switchCurrencyTapped), for: .touchUpInside)
        currencyRateViewModel.getCurrencies()
        currencyRateViewModel.getCurrencyRates(baseCurrencySymbol: "USD")
    }
    
    override func observeEvents() {
        currencyRateViewModel.hideCurrencyInput.bind(to: currencyRateView.inputCurrencyTextField.rx.isHidden).disposed(by: currencyRateViewModel.bag)
        currencyRateViewModel.hideCurrencyInput.bind(to: currencyRateView.outputCurrencyTextField.rx.isHidden).disposed(by: currencyRateViewModel.bag)
        
        currencyRateViewModel.fromCurrency.bind(to: currencyRateView.fromTextField.rx.text).disposed(by: currencyRateViewModel.bag)
        currencyRateViewModel.toCurrency.bind(to: currencyRateView.toTextField.rx.text).disposed(by: currencyRateViewModel.bag)
        
        currencyRateViewModel.hideCurrencyInput.map({!$0}).bind(to: currencyRateView.switchCurrencyButton.rx.isEnabled).disposed(by: currencyRateViewModel.bag)
        inputOutputRateObserveTextField()
        observeData()
    }
    
    func inputOutputRateObserveTextField() {
        currencyRateView.inputCurrencyTextField.delegate = self
        currencyRateViewModel.outputCurrency.map({"\($0)"}).bind(to: currencyRateView.outputCurrencyTextField.rx.text).disposed(by: currencyRateViewModel.bag)
    }
    
    private func observeData() {
        currencyRateViewModel.currencies.skip(1).subscribe { [weak self] _ in
            guard let self = self else {return}
            self.currencyRateViewModel.isCurrenciesFetching = false
            DispatchQueue.main.async {
                if self.requestedTextField == .fromTextField {
                    self.currencyRateView.fromTextField.becomeFirstResponder()
                } else if self.requestedTextField == .toTextField {
                    self.currencyRateView.toTextField.becomeFirstResponder()
                }
            }
        }.disposed(by: currencyRateViewModel.bag)
        
        currencyRateViewModel.errorFound.subscribe { [weak self] message in
            guard let self = self else {return}
            self.currencyRateViewModel.isCurrenciesFetching = false
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }.disposed(by: currencyRateViewModel.bag)
    }
    
    @objc func fromDoneTapped(_ sender: Any) {
        let symbol = currencyRateViewModel.currencies.value[picker.selectedRow(inComponent: 0)]
        currencyRateViewModel.fromCurrency.accept(symbol.symbol)
    }
    
    @objc func toDoneTapped(_ sender: Any) {
        let symbol = currencyRateViewModel.currencies.value[picker.selectedRow(inComponent: 0)]
        currencyRateViewModel.toCurrency.accept(symbol.symbol)
    }
    
    @objc func gotoDetailView() {
        
    }
    
    @objc func switchCurrencyTapped() {
        currencyRateViewModel.switchCurrency()
        currencyRateView.inputCurrencyTextField.text = "1"
    }
}

extension CurrencyRateViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if currencyRateViewModel.currencies.value.isEmpty && textField != currencyRateView.inputCurrencyTextField {
            if textField == currencyRateView.fromTextField {
                requestedTextField = .fromTextField
            } else if textField == currencyRateView.toTextField {
                requestedTextField = .toTextField
            } else {
                requestedTextField = .nothing
            }
            currencyRateViewModel.getCurrencies()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == currencyRateView.inputCurrencyTextField {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                let rate: Double = Double(updatedText) ?? 1
                currencyRateViewModel.inputCurrency.accept(rate)
            }
        }
        
        return true
    }
}
