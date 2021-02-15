//
//  Shelf+CoreDataProperties.swift
//  raid-list
//
//  Created by Noice Dious on 15/02/2021.
//
//

import Foundation
import CoreData


extension Shelf {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shelf> {
        return NSFetchRequest<Shelf>(entityName: "Shelf")
    }

    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Shelf {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Shelf : Identifiable {

}
