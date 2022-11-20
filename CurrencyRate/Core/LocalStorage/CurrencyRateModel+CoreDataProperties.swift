//
//  CurrencyRateModel+CoreDataProperties.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//
//

import Foundation
import CoreData


extension CurrencyRateModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyRateModel> {
        return NSFetchRequest<CurrencyRateModel>(entityName: "CurrencyRateModel")
    }

    @NSManaged public var rate: Double
    @NSManaged public var symbol: String?
    @NSManaged public var isBase: Bool

}

extension CurrencyRateModel : Identifiable {

}
