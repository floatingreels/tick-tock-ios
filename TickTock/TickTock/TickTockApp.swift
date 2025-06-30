//
//  TickTockApp.swift
//  TickTock
//
//  Created by David Gunzburg on 16/05/2025.
//

import SwiftUI

@main
struct TickTockApp: App {
    
    @State private var storeManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            NavigatableView(root: storeManager.authStore.isLoggedIn ? AppScreen.home : AppScreen.welcome)
                .environment(storeManager)
                .environment(storeManager.authStore)
                .environment(storeManager.projectStore)
                .environment(storeManager.sessionStore)
                .environment(storeManager.clientStore)
        }
    }
}
