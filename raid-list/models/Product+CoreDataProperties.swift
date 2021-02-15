//
//  Product+CoreDataProperties.swift
//  raid-list
//
//  Created by Noice Dious on 15/02/2021.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var name: String?
    @NSManaged private var units: [Int]?
    @NSManaged public var list: ProductList?
    @NSManaged public var shelf: Shelf?

    public var availableUnits: [UnitSystem] {
        get {
            return units!.map {
                return UnitSystem(rawValue: $0)!
            }
        }
        set {
            units = newValue.map {
                $0.rawValue
            }
        }
    }
}

extension Product : Identifiable {

}
