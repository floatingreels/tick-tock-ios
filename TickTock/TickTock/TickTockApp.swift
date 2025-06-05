//
//  TickTockApp.swift
//  TickTock
//
//  Created by David Gunzburg on 16/05/2025.
//

import SwiftUI

@main
struct TickTockApp: App {
    
    @ObservedObject private var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            NavigatableView(root: authManager.isLoggedIn ? AppScreen.home : AppScreen.welcome)
        }
    }
}
