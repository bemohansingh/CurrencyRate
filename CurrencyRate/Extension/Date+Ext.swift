//
//  Date+Ext.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

extension Date? {
    func toString(isDateOnly: Bool = false) -> String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if !isDateOnly {
            formatter.timeStyle = .short
        }
        if let date = self {
            return formatter.string(from: date)
        }
        return nil
    }
}

extension Calendar {
    func numberOfDaysBetween(fromDate: Date, toDate: Date) -> Int {
        let fromDate = startOfDay(for: fromDate)
        let toDate = startOfDay(for: toDate)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day ?? 0
    }
}
