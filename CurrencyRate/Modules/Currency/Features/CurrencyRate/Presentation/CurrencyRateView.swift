//
//  CurrencyRateView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import UIKit

class CurrencyRateView: BaseView {
    lazy var fromTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "From"
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.tintColor = .white
        //dropdown icon
        textField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 22, width: 16, height: 12))
        let image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .gray
        imageView.image = image
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 55))
        imageContainerView.addSubview(imageView)
        textField.rightView = imageContainerView
        return textField
    }()
    
    lazy var toTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "To"
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.tintColor = .white
        //dropdown icon
        textField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 22, width: 16, height: 12))
        let image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .gray
        imageView.image = image
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 55))
        imageContainerView.addSubview(imageView)
        textField.rightView = imageContainerView
        return textField
    }()
    
    lazy var inputCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.text = "1"
        return textField
    }()
    
    lazy var outputCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        textField.placeholder = "Amount"
        textField.text = "1"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        return textField
    }()
    
    lazy var switchCurrencyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        return button
    }()
    
    lazy var detailCurrencyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Detail", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 27.5
        return button
    }()
    
    override func create() {
        backgroundColor = .white
        addSubview(fromTextField)
        addSubview(switchCurrencyButton)
        addSubview(toTextField)
        
        addSubview(inputCurrencyTextField)
        addSubview(outputCurrencyTextField)
        addSubview(detailCurrencyButton)
        
        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 55),
            fromTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fromTextField.trailingAnchor.constraint(equalTo: switchCurrencyButton.leadingAnchor, constant: -16),
            fromTextField.heightAnchor.constraint(equalToConstant: 55),
            
            switchCurrencyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 55),
            switchCurrencyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchCurrencyButton.trailingAnchor.constraint(equalTo: toTextField.leadingAnchor, constant: -16),
            switchCurrencyButton.heightAnchor.constraint(equalToConstant: 55),
            switchCurrencyButton.widthAnchor.constraint(equalToConstant: 55),
            
            toTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 55),
            toTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 55),
            
            
            inputCurrencyTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 25),
            inputCurrencyTextField.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
            inputCurrencyTextField.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            inputCurrencyTextField.heightAnchor.constraint(equalToConstant: 55),
            
            outputCurrencyTextField.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 25),
            outputCurrencyTextField.leadingAnchor.constraint(equalTo: toTextField.leadingAnchor),
            outputCurrencyTextField.trailingAnchor.constraint(equalTo: toTextField.trailingAnchor),
            outputCurrencyTextField.heightAnchor.constraint(equalToConstant: 55),
            
            detailCurrencyButton.topAnchor.constraint(equalTo: inputCurrencyTextField.bottomAnchor, constant: 55),
            detailCurrencyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailCurrencyButton.heightAnchor.constraint(equalToConstant: 55),
            detailCurrencyButton.widthAnchor.constraint(equalToConstant: 155)
        ])
    }
}
