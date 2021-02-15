//
//  Persistence.swift
//  raid-list
//
//  Created by Noice Dious on 05/02/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let 🥗 = Shelf(context: viewContext)
        🥗.name = "undefined"
        
        let mercery = Shelf(context: viewContext)
        mercery.name = "mercery"
        
        let fruits = Shelf(context: viewContext)
        fruits.name = "fruits"
        
        let 🍎 = Product(context: viewContext)
        🍎.name = "apple"
        🍎.shelf = 🥗
        🍎.availableUnits = [.none, .grams, .kilograms]
        
        let 🌶 = Product(context: viewContext)
        🌶.name = "chili"
        🌶.shelf = 🥗
        🌶.availableUnits = [.none, .grams, .kilograms]
        
        let apples = ProductList(context: viewContext)
        apples.product = 🍎
        apples.quantity = "1"
        apples.unit = .kilograms
        apples.isChecked = false
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error in Persistence::preview : \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error in Persistence::init : \(error), \(error.userInfo)")
            }
        })
    }
}
