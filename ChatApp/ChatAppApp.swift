//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI

@main
struct ChatAppApp: App {
    
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(.hiddenTitleBar)
        
    }
}
