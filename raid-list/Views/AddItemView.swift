//
//  AddItemView.swift
//  raid-list
//
//  Created by Noice Dious on 07/02/2021.
//

import SwiftUI
import Combine

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Product.name, ascending: true)
        ],
        animation: .default
    ) var products: FetchedResults<Product>
    
    @State var nameValue: String = ""
    
    @State var productList: [Product] = []
    
    @State var isNewProductSheetPresented: Bool = false
    
    @State var isAddProductSheetPresented: Bool = false
    
    @State var presentList: Bool = false
    
    @State var selected: Product = Product()
    
    var body: some View {
        let sheetIsPresented = Binding<Bool>(get: {
            return self.isNewProductSheetPresented
        }, set: {
            self.isNewProductSheetPresented = $0
        })
        
        NavigationView {
            VStack {
                TextField("search_product", text: $nameValue)
                    .padding(15)
                    .onChange(of: nameValue) { newState in
                        withAnimation {
                            self.productList = products.filter { (product) -> Bool in
                                if (newState == "") {
                                    return true;
                                }
                                return (product.name?.range(of: newState, options: .caseInsensitive) ?? nil) != nil
                            }
                        }
                    }
                
                Button(action: {
                    self.isNewProductSheetPresented = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("create_product")
                    }
                }
                
                List(productList) { product in
                    Button(action: {
                        self.selected = product
                        self.isAddProductSheetPresented = true
                    }) {
                        Text("\(product.name ?? "blob")")
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear(perform: {
                    withAnimation {
                        self.productList = products.filter { (product) -> Bool in
                            return true
                        }
                    }
                })
            }
            .navigationBarTitle("add_item")
            .sheet(isPresented: $isNewProductSheetPresented) {
                NewProductView(productName: $nameValue, isPresented: sheetIsPresented, selected: $selected).environment(\.managedObjectContext, viewContext)
            }
            .sheet(isPresented: $isAddProductSheetPresented) {
                ModalContentView(selected: $selected).environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct ModalContentView: View {
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selected: Product
    
    @State var selectedUnit: UnitSystem = .none
    
    @State var selectedQuantity: String = ""

    var body: some View {
        Form {
            Text(selected.name ?? "blob")
            
            TextField("quantity", text: $selectedQuantity)
                .keyboardType(.numberPad)
            
            Picker(selection: $selectedUnit, label: Text("unit")) {
                ForEach(0 ..< selected.availableUnits.count) {
                    let content = "\(selected.availableUnits[$0].name())"
                    Text(content).tag(selected.availableUnits[$0].abbr())
                }
            }

            HStack {
                Button(action: {
                    let product = ProductList(context: viewContext)
                    
                    product.product = selected
                    
                    product.quantity = Float(selectedQuantity) ?? 0

                    product.unit = selectedUnit
                    
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }, label: {
                    Text("add")
                })
                
                Spacer()
                
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("cancel")
                })
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
