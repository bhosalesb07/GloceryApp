//
//  Migrator.swift
//  GloceryApp
//
//  Created by Apple on 01/08/25.
//

import Foundation
import RealmSwift

class Migrator {
    init() {
        updateSchema()
    }

    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: ShoppingList.className()) { _, newObject in
                    newObject?["items"] = List<ShoppingItem>()
                }
            }
            
            if oldSchemaVersion < 3{
                migration.enumerateObjects(ofType: ShoppingItem.className()) { _, newObject in
                    newObject?["category"] = ""
                }
            }
            
        }
        Realm.Configuration.defaultConfiguration = config
        do {
            print("Success")
            _ = try Realm()
        } catch {
            print("Realm initialization failed: \(error)")
        }
    }
}
