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
    
    var itemtoEdit :ShoppingItem?
    private var isEditing:Bool{
        itemtoEdit == nil ? false : true
    }
    @Environment(\.dismiss) var dissmiss
    
    let column = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    let data = ["Produce","Fruit","Meat","Condiments","Beverages","Snacks"," Dairy"]
    
    init(shoppingList:ShoppingList,itemtoEdit:ShoppingItem? = nil){
        self.shoppingList = shoppingList
        self.itemtoEdit = itemtoEdit
        
        if let itemtoEdit = itemtoEdit{
            _title = State(initialValue: itemtoEdit.title)
            _quantity = State(initialValue:  String(itemtoEdit.quantity))
            _selectedCategory = State(initialValue: itemtoEdit.category)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            if !isEditing {
                Text("Add Item").font(.largeTitle)
            }
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
                    if let _ = itemtoEdit{
                        update()
                    }else{
                        save()
                    }
                   
                    dissmiss()
                } label: {
                    Text(isEditing == true ? "Update" : "Save").frame(maxWidth: .infinity,maxHeight: 40)
                    
                }.buttonStyle(.bordered).padding(.top,20)
                Spacer()
                
                    .navigationTitle(isEditing == true ? "Update Item": "Add Item")
//                .background(.gray)
//                .foregroundStyle(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                

            }.padding()
        
    }
   private func save(){
        let shopping_Item = ShoppingItem()
        shopping_Item.title = title
        shopping_Item.quantity = Int(quantity) ?? 1
        shopping_Item.category = selectedCategory
        $shoppingList.items.append(shopping_Item)
    }
    private func update(){
        if let itemtoedit = itemtoEdit{
            
            do{
                let realm = try Realm()
                guard let objecttoUpdate = realm.object(ofType: ShoppingItem.self, forPrimaryKey: itemtoedit.id) else { return }
                try realm.write {
                    objecttoUpdate.title = title
                    objecttoUpdate.category = selectedCategory
                    objecttoUpdate.quantity = Int(quantity) ?? 1
                }
            }catch{
                print(error)
            }
        }
    }
}

#Preview {
    
    AddShoppingListItemScreen(shoppingList: ShoppingList())
}
