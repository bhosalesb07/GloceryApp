//
//  ContentView.swift
//  GloceryApp
//
//  Created by Apple on 31/07/25.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedResults(ShoppingList.self) var shoppingList
    @State private var isPresented:Bool = false
    var body: some View {
        NavigationView{
            VStack {
                
                if shoppingList.isEmpty{
                    Text("No shopping List")
                }
                List{
                    ForEach(shoppingList,id: \.id) { shopping_List in
                        NavigationLink{
                            ShoppingListItemScreen(shoppingList: shopping_List)
                        }label:{
                            VStack(alignment:.leading){
                                Text(shopping_List.title)
                                Text(shopping_List.address).opacity(0.4)
                            }
                        }
                        
                    }.onDelete(perform: $shoppingList.remove)
                }
                    .navigationTitle("Glocery App")
            }
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen()
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        //
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
           
        }
    }
}

#Preview {
    ContentView()
}
