//
//  HistoryView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

class HistoryView: BaseView {
    lazy var leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var landscapeConstraints: [NSLayoutConstraint] = []
    var potraitConstraints: [NSLayoutConstraint] = []
    
    override func create() {
        backgroundColor = .white
        addSubview(leftView)
        addSubview(rightView)
        landscapeConstraints = [self.leftView.topAnchor.constraint(equalTo: self.topAnchor),
                                self.leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                self.leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                self.leftView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.34),
                                self.rightView.topAnchor.constraint(equalTo: self.topAnchor),
                                self.rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
                                self.rightView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                self.rightView.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
        
        potraitConstraints = [self.leftView.topAnchor.constraint(equalTo: self.topAnchor),
                              self.leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                              self.leftView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                              self.leftView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.34),
                              self.rightView.topAnchor.constraint(equalTo: leftView.bottomAnchor),
                              self.rightView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                              self.rightView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                              self.rightView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        
        if traitCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(potraitConstraints)
        }
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
    func activatePotraitMode() {
        NSLayoutConstraint.activate([
            self.leftView.topAnchor.constraint(equalTo: self.topAnchor),
            self.leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leftView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.leftView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func activateLandscpateMode() {
        NSLayoutConstraint.deactivate([self.leftView.topAnchor.constraint(equalTo: self.topAnchor),
                                       self.leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                       self.leftView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                       self.leftView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)])
        NSLayoutConstraint.activate([
            self.leftView.topAnchor.constraint(equalTo: self.topAnchor),
            self.leftView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.leftView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
    }
}
