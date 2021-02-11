//
//  NewProductView.swift
//  raid-list
//
//  Created by Noice Dious on 07/02/2021.
//

import SwiftUI

struct NewProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var productName: String
    
    @Binding var isPresented: Bool
    
    @Binding var selected: Product
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Department.name, ascending: true)
        ],
        animation: .default
    ) var departments: FetchedResults<Department>
    
    @State var name: String = ""
    @State var isG: Bool = false
    @State var isKG: Bool = false
    @State var isL: Bool = false
    @State var isI: Bool = false
    @State var selectedDepartment: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("product")) {
                    TextField("product_name", text: $name)
                }
                .onAppear(perform: {
                    self.name = productName
                })
                
                Section(header: Text("units")) {
                    Toggle(isOn: $isG) {
                        Text("grams")
                    }
                    Toggle(isOn: $isKG) {
                        Text("kilograms")
                    }
                    Toggle(isOn: $isL) {
                        Text("liters")
                    }
                    Toggle(isOn: $isI) {
                        Text("item")
                    }
                }
                
                Section(header: Text("department")) {
                    Picker(selection: $selectedDepartment, label: Text("select")) {
                        ForEach(0 ..< departments.count) {
                            let content = "\(departments[$0].name ?? "undefined")"
                            Text(content).tag(content)
                        }
                    }
                }
                
                Button(action: saveItem) {
                    Text("add_item")
                }
            }
            .navigationTitle("new_product")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func saveItem() {
        let newProduct = Product(context: viewContext)
        newProduct.name = name
        
        newProduct.departement = departments.first { (department) -> Bool in
            return department.name == selectedDepartment
        }
        
        newProduct.availableUnits = [.none]
        
        if (isG) {
            newProduct.availableUnits.append(.grams)
        }
        if (isKG) {
            newProduct.availableUnits.append(.kilograms)
        }
        if (isL) {
            newProduct.availableUnits.append(.liters)
        }
        if (isI) {
            newProduct.availableUnits.append(.items)
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        self.selected = newProduct;
        self.isPresented = false;
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        
        NewProductView(productName: .constant("eau"), isPresented: .constant(true), selected: .constant(Product())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

