//
//  ConfigItemView.swift
//  raid-list
//
//  Created by Noice Dious on 08/02/2021.
//

import SwiftUI

struct ConfigItemView: View {
    
    @Binding var selected: Product
    
    @State var selectedUnit: String = ""
    
    @State var selectedQuantity: String = ""
    
    // @State var units: [UnitSystem] = []

    var body: some View {
        Form {
            TextField("quantity", text: $selectedQuantity)
                .keyboardType(.numberPad)
            
            Picker(selection: $selectedUnit, label: Text("quantity")) {
                let units = selected.units!.allObjects as! [UnitSystem]
                ForEach(0 ..< units.count) {
                    let content = "\(units[$0].name ?? "undefined")"
                    Text(content).tag(content)
                }
            }
        }
    }
}

struct ConfigItemView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigItemView(selected: .constant(Product())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

