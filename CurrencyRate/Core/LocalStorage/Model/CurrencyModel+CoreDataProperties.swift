//
//  CurrencyModel+CoreDataProperties.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//
//

import Foundation
import CoreData

extension CurrencyModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyModel> {
        return NSFetchRequest<CurrencyModel>(entityName: "CurrencyModel")
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String

}

extension CurrencyModel: Identifiable {
}
