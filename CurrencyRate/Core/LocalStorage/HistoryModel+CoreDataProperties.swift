//
//  HistoryModel+CoreDataProperties.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//
//

import Foundation
import CoreData


extension HistoryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryModel> {
        return NSFetchRequest<HistoryModel>(entityName: "HistoryModel")
    }

    @NSManaged public var fromSymbol: Double
    @NSManaged public var toSymbol: Double
    @NSManaged public var toRate: Double
    @NSManaged public var createdAt: Date?

}

extension HistoryModel : Identifiable {

}
