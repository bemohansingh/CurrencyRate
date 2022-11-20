//
//  History+TableView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import UIKit

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let hCount = historyViewModel.histories.value.count
        let rCount = historyViewModel.latestRates.value.count
        return hCount > rCount ? hCount : rCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryCell.self)) as? HistoryCell else {return UITableViewCell()}
        let hCount = historyViewModel.histories.value.count
        let rCount = historyViewModel.latestRates.value.count
        let historyModel: HistoryModel? = indexPath.row < hCount ? historyViewModel.histories.value[indexPath.row] : nil
        let rateModel: LatestRate? = indexPath.row < rCount ? historyViewModel.latestRates.value[indexPath.row] : nil
            cell.configure(history: historyModel, latestRate: rateModel)
            return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                   "sectionHeader") as? HistoryHeaderView
        view?.noHistoryLabel.isHidden = !historyViewModel.histories.value.isEmpty
       return view
    }
}
