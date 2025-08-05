//
//  AddShoppingListItemScreen.swift
//  GloceryApp
//
//  Created by Apple on 01/08/25.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemScreen: View {
    @State private var title:String = ""
    @State private var quantity:String = ""
    @State private var selectedCategory:String = ""
    
    @ObservedRealmObject var shoppingList:ShoppingList
    @Environment(\.dismiss) var dissmiss
    
    let column = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    let data = ["Produce","Fruit","Meat","Condiments","Beverages","Snacks"," Dairy"]
    var body: some View {
        NavigationView{
            VStack{
                LazyVGrid(columns: column){
                    ForEach(data,id: \.self){ item in
                        Text(item).padding()
                        .frame(width: 130)
                        .background(selectedCategory == item ? .orange : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .onTapGesture {
                            selectedCategory = item
                        }
                    }
                }
                Spacer().frame(height: 60)
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(.roundedBorder)

                Button {
                    //
                    let shopping_Item = ShoppingItem()
                    shopping_Item.title = title
                    shopping_Item.quantity = Int(quantity) ?? 1
                    shopping_Item.category = selectedCategory
                    $shoppingList.items.append(shopping_Item)
                    dissmiss()
                } label: {
                    Text("Save").frame(maxWidth: .infinity,maxHeight: 40)
                    
                }.buttonStyle(.bordered).padding(.top,20)
                Spacer()
                
                    .navigationTitle("Add Item")
//                .background(.gray)
//                .foregroundStyle(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                

            }.padding()
        }
    }
}

#Preview {
    AddShoppingListItemScreen(shoppingList: ShoppingList())
}
