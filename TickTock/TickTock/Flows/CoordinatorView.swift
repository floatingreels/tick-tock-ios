//
//  CoordinatorView.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
                coordinator.build(AppScreen.welcome)
                    .navigationDestination(for: AppScreen.self) { screen in
                        coordinator.build(screen)
                    }
            // TODO: wrap around the following if-statement once JWT tokens are implemented
//            if let authToken = BackendCredentials.shared.getAccessToken() {
//            } else {
//                coordinator.build(AppScreen.home)
//                    .navigationDestination(for: AppScreen.self) { screen in
//                        coordinator.build(screen)
//                    }
//            }
        }
        .environmentObject(coordinator)
    }
}
