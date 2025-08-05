//
//  GloceryAppApp.swift
//  GloceryApp
//
//  Created by Apple on 31/07/25.
//

import SwiftUI

@main
struct GloceryAppApp: App {
    let migrator = Migrator()
    var body: some Scene {
        
        WindowGroup {
            
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
