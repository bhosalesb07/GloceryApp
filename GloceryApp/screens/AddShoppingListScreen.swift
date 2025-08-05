//
//  AddShoppingListScreen.swift
//  GloceryApp
//
//  Created by Apple on 31/07/25.
//

import SwiftUI
import RealmSwift

struct AddShoppingListScreen: View {
    @State private var title :String = ""
    @State private var address: String = ""
    
    @ObservedResults(ShoppingList.self) var shoppingList
    @Environment(\.dismiss) private var dissmiss
    var body: some View {
        NavigationView{
            Form{
                TextField("Enter Title", text: $title)
                TextField("Enter Address", text: $address)
                Button(action: {
                    //
                    
                    let shopping_List = ShoppingList()
                    shopping_List.title = title
                    shopping_List.address = address
                    $shoppingList.append(shopping_List)
                    dissmiss()
                }, label: {
                    Text("Save").frame(maxWidth:.infinity)
                        
                }).buttonStyle(.bordered)

            }
                .navigationTitle("New List")
        }
       
    }
}

#Preview {
    AddShoppingListScreen()
}
