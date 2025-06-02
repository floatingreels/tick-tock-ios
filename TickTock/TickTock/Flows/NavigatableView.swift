//
//  CoordinatorView.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

struct NavigatableView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color.backgroundPrimary
                coordinator.build(BackendCredentials.shared.getAccessToken() != nil ? AppScreen.home : AppScreen.welcome)
                    .padding(Spacing.interItem)
                    .navigationDestination(for: AppScreen.self) { screen in
                        if screen.shouldHideBackButton() {
                            coordinator.build(screen).navigationBarBackButtonHidden()
                        } else {
                            coordinator.build(screen)
                        }
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.buildSheet(sheet)
                    }
            }
            .ignoresSafeArea()
            .font(Font.body())
        }
        .environmentObject(coordinator)
    }
}
