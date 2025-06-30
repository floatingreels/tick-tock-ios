//
//  CoordinatorView.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

typealias DismissHandler = () -> Void
typealias PresentHandler = () -> Void

struct NavigatableView: View {
    
    @StateObject private var coordinator = Coordinator()
    @StateObject private var alertinator = Alertinator()
    private var root: AppScreen
    
    init(root: AppScreen) {
        self.root = root
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color.backgroundPrimary.ignoresSafeArea()
                coordinator.buildScreen(root)
                    .navigationBarTitleDisplayMode(root.hasLargeTitles ? .large : .inline)
                    .navigationDestination(for: AppScreen.self) { screen in
                        ZStack {
                            Color.backgroundPrimary.ignoresSafeArea()
                            coordinator.buildScreen(screen)
                                .navigationBarBackButtonHidden(screen.hidesBackButton)
                                .navigationBarTitleDisplayMode(screen.hasLargeTitles ? .large : .inline)
                        }
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.buildSheet(sheet)
                    }
                    .alert($alertinator.alert)
            }
        }
        .font(Font.body())
        .textFieldStyle(.roundedBorder)
        .environmentObject(coordinator)
        .environmentObject(alertinator)
    }
}

enum ToolBarButtonType: String {
    case settings = "gearshape.fill"
    case add = "plus"
    case edit = "pencil"
    case delete = "trash.fill"
}
