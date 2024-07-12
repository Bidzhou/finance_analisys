//
//  Purchase+CoreDataProperties.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 12.07.2024.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var price: Int64
    @NSManaged public var store: String?

}

extension Purchase : Identifiable {

}
