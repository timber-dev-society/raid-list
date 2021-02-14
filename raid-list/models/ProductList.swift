//
//  ProductList.swift
//  raid-list
//
//  Created by Noice Dious on 09/02/2021.
//

import Foundation
import CoreData


public class ProductList: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged private var checked: NSNumber?
    @NSManaged public var quantity: String?
    @NSManaged private var unitSystem: NSNumber?
    @NSManaged public var product: Product?

    public var unit: UnitSystem {
        get {
            return UnitSystem(rawValue: Int(truncating: unitSystem ?? 0) ) ?? .none
        }
        set {
            unitSystem = NSNumber(value: newValue.rawValue)
        }
    }
    
    public var isChecked: Bool {
        get {
            return Bool(exactly: checked ?? 0) ?? false
        }
        set {
            checked = NSNumber(booleanLiteral: newValue)
        }
    }

}

extension ProductList : Identifiable {

}
