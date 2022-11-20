//
//  HistoryCell.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    lazy var backgroundHistoryCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    lazy var backgroundLatestCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rateLatestLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyLatestLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(11)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        create()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func create() {
        contentView.addSubview(backgroundHistoryCellView)
        contentView.addSubview(backgroundLatestCellView)
        backgroundHistoryCellView.addSubview(dateLabel)
        backgroundHistoryCellView.addSubview(currencyLabel)
        backgroundHistoryCellView.addSubview(rateLabel)
        backgroundLatestCellView.addSubview(currencyLatestLabel)
        backgroundLatestCellView.addSubview(rateLatestLabel)
        
        NSLayoutConstraint.activate([
            backgroundHistoryCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            backgroundHistoryCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundHistoryCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            backgroundHistoryCellView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -4),
            
            backgroundLatestCellView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4),
            backgroundLatestCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundLatestCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            backgroundLatestCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            currencyLabel.leadingAnchor.constraint(equalTo: backgroundHistoryCellView.leadingAnchor, constant: 4),
            currencyLabel.topAnchor.constraint(equalTo: backgroundHistoryCellView.topAnchor, constant: 4),
            currencyLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4),
            
            rateLabel.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 4),
            rateLabel.topAnchor.constraint(equalTo: backgroundHistoryCellView.topAnchor, constant: 4),
            rateLabel.trailingAnchor.constraint(equalTo: backgroundHistoryCellView.trailingAnchor, constant: -4),
            
            dateLabel.bottomAnchor.constraint(equalTo: backgroundHistoryCellView.bottomAnchor, constant: -4),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundHistoryCellView.leadingAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundHistoryCellView.trailingAnchor, constant: -4),
            
            currencyLatestLabel.leadingAnchor.constraint(equalTo: backgroundLatestCellView.leadingAnchor, constant: 4),
            currencyLatestLabel.topAnchor.constraint(equalTo: backgroundLatestCellView.topAnchor, constant: 4),
            currencyLatestLabel.trailingAnchor.constraint(equalTo: backgroundLatestCellView.trailingAnchor, constant: -4),
            currencyLatestLabel.bottomAnchor.constraint(equalTo: rateLatestLabel.topAnchor, constant: -4),
            
            rateLatestLabel.bottomAnchor.constraint(equalTo: backgroundLatestCellView.bottomAnchor, constant: -4),
            rateLatestLabel.leadingAnchor.constraint(equalTo: backgroundLatestCellView.leadingAnchor, constant: 4),
            rateLatestLabel.trailingAnchor.constraint(equalTo: backgroundLatestCellView.trailingAnchor, constant: -4)
        ])
    }
    
    func configure(history: HistoryModel?, latestRate: LatestRate? = nil) {
        self.selectionStyle = .none
        backgroundHistoryCellView.isHidden = history == nil
        backgroundLatestCellView.isHidden = latestRate == nil
        
        if let history = history {
            self.dateLabel.text = history.createdAt.toString()
            let rate = round(history.toRate * 100000) / 10000
            self.currencyLabel.text = "\(history.fromSymbol):\(history.toSymbol)"
            self.rateLabel.text = "1:\(rate)"
        }
        
        if let latestRate = latestRate {
            self.currencyLatestLabel.text = "\(latestRate.fromSymbol):\(latestRate.toSymbol)"
            let rate = round(latestRate.rate * 100000) / 10000
            self.rateLatestLabel.text = "1:\(rate)"
        }
        
    }
}
