//
//  ContentView.swift
//  raid-list
//
//  Created by Noice Dious on 05/02/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showNewProductSheet = false

    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) var productToBuy: FetchedResults<ProductList>
    
    /* productToBuy.sort{
        $0.product.type < $1.product.type
    }
    
    var tasks: [ProductToBuy] = testProductList.filter { (product) -> Bool in
        return !product.checked
    }.sorted {
        $0.product.type < $1.product.type
    }
    
    var checkedTasks: [ProductToBuy] = testProductList.filter { (product) -> Bool in
        return product.checked
    }*/

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(productToBuy) { item in
                        HStack {
                            Button(action: {
                                self.showNewProductSheet = true
                            }) {
                                Label("Toggle Item", systemImage: "circle")
                            }.labelStyle(IconOnlyLabelStyle())
                            
                            Text("\(item.product?.name ?? "blob") ")
                            Spacer()
                            Text("\(item.quantity) \(item.unit?.abbr ?? "?")")
                                .foregroundColor(Color(UIColor.systemGray3))
                                .font(.caption)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .sheet(isPresented: $showNewProductSheet) {
                AddItemView()
            }
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack (spacing: 220) {
                        Button(action: addItem) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("add_item")
                            }
                        }
                        
                        
                        EditButton()
                    }
                    .padding()
                    .accentColor(Color(UIColor.systemPink))
                    
                }
                #endif
                
                ToolbarItem(placement: .bottomBar) {
                    
                    
                }
            }
            .navigationTitle("Raid list")
        }
        
    }

    private func addItem() {
        withAnimation {
            self.showNewProductSheet = true

           saveContext()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { tasks[$0] }.forEach(viewContext.delete)

           saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
