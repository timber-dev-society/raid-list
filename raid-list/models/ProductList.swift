//
//  ProductList.swift
//  raid-list
//
//  Created by Noice Dious on 09/02/2021.
//

import Foundation
import CoreData


class ProductList: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var quantity: Float
    @NSManaged private var unitSystem: Int
    
    public var unit: UnitSystem {
        get {
            return UnitSystem(rawValue: unitSystem)!
        }
        set {
            unitSystem = newValue.rawValue
        }
    }
    @NSManaged public var product: Product?

}

extension ProductList : Identifiable {

}
