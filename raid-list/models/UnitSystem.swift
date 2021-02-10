//
//  UnitSystem.swift
//  raid-list
//
//  Created by Noice Dious on 09/02/2021.
//

import Foundation

@objc enum UnitSystem: Int, Equatable, CaseIterable {
    case none = 0, grams = 1, kilograms = 2, liters = 3, items = 4
    
    // var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
    func abbr() -> String {
        switch self {
        case .kilograms:
            return "kg"
        case .grams:
            return "g"
        case .liters:
            return "l"
        case .items:
            return "i"
        case .none:
            return ""
        }
    }
    
    func name() -> String {
        switch self {
        case .kilograms:
            return "kilograms"
        case .grams:
            return "grams"
        case .liters:
            return "liters"
        case .items:
            return "items"
        case .none:
            return "none"
        }
    }
    
    init?(id : Int) {
        switch id {
            case 0: self = .none
            case 1: self = .grams
            case 2: self = .kilograms
            case 3: self = .liters
            case 4: self = .items
            default: return nil
        }
    }
    
    func getAll() -> [UnitSystem] {
        return UnitSystem.allCases
    }
}
