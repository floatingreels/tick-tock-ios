//
//  CoordinatorView.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

typealias DismissHandler = () -> Void

struct NavigatableView: View {
    
    @StateObject private var coordinator = Coordinator()
    private var root: AppScreen
    
    init(root: AppScreen) {
        self.root = root
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color.backgroundPrimary
                coordinator.buildScreen(root)
                    .navigationBarTitleDisplayMode(root.hasLargeTitles ? .large : .inline)
                    .navigationDestination(for: AppScreen.self) { screen in
                        coordinator.buildScreen(screen)
                            .navigationBarBackButtonHidden(screen.hidesBackButton)
                            .navigationBarTitleDisplayMode(screen.hasLargeTitles ? .large : .inline)
                            .padding(Spacing.interItem)
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.buildSheet(sheet)
                    }
                    .font(Font.body())
            }
        }
        .environmentObject(coordinator)
    }
}

enum ToolBarButtonType: String {
    case settings = "gearshape"
    case add = "plus"
    case edit = "pencil"
    case delete = "trash.fill"
}
