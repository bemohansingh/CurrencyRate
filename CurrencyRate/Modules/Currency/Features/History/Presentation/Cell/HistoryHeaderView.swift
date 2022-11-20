//
//  HistoryHeaderView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

class HistoryHeaderView: UITableViewHeaderFooterView {
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.text = "Histories"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var latestRateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.text = "Latest Rates"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noHistoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "(History not found)"
        label.font = label.font.withSize(11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(headerTitle)
        contentView.addSubview(noHistoryLabel)
        contentView.addSubview(latestRateTitle)

        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerTitle.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4),
            
            noHistoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noHistoryLabel.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 4),
            noHistoryLabel.trailingAnchor.constraint(equalTo: headerTitle.trailingAnchor),
            noHistoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            latestRateTitle.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4),
            latestRateTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            latestRateTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            latestRateTitle.bottomAnchor.constraint(equalTo: headerTitle.bottomAnchor)
        ])
    }
}
