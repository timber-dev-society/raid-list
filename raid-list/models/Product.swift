//
//  Product.swift
//  raid-list
//
//  Created by Noice Dious on 09/02/2021.
//

import Foundation
import CoreData


public class Product: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged private var units: Array<Int>?
    @NSManaged public var shelf: Shelf?
    @NSManaged public var lists: ProductList?
    
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
