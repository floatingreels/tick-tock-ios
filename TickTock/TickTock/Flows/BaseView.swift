//
//  BaseView.swift
//  TickTock
//
//  Created by David Gunzburg on 24/05/2025.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    
    @StateObject private var coordinator = Coordinator()
    
    private let bgColor = Color.backgroundPrimary
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                bgColor
                content
            }
        }
        .navigationDestination(for: String.self) { screen in
            screen
        }
    }
}
