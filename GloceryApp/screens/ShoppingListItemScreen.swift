//
//  ShoppingListItemScreen.swift
//  GloceryApp
//
//  Created by Apple on 01/08/25.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemScreen: View {
    @ObservedRealmObject var shoppingList:ShoppingList
    @State private var isPresented:Bool = false
    @State private var selectedItemIds:[ObjectId] = []
    @State private var selectedCategory:String = "All"
    
    
    var item :[ShoppingItem]{
        if (selectedCategory == "All"){
            return Array(shoppingList.items)
        }else{
            return shoppingList.items.sorted(byKeyPath: "title").filter{$0.category == selectedCategory}
        }
    }
    var body: some View {
        VStack{
            CategoryFilterView(selectedCategory: $selectedCategory)
            if item.isEmpty{
                Text("No Items Found")
            }
            List{
                ForEach(item){ items in
                    ShoppingItemCell(item: items, selected: selectedItemIds.contains(items.id)) { selected in
                        if selected{
                            selectedItemIds.append(items.id)
                            if let indextoDelete = shoppingList.items.firstIndex(where: {$0.id == items.id}){
                                $shoppingList.items.remove(at: indextoDelete)
                            }
                        }
                    }
                }.onDelete(perform: $shoppingList.items.remove)
            }
            .navigationTitle(shoppingList.title)
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            AddShoppingListItemScreen(shoppingList: shoppingList)
        }
       
    }
}

#Preview {
    NavigationView{
        ShoppingListItemScreen(shoppingList: ShoppingList())
    }
}
