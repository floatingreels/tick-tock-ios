//
//  Coordinator.swift
//  TickTock
//
//  Created by David Gunzburg on 25/05/2025.
//  Thanks to: https://www.swiftanytime.com/blog/coordinator-pattern-in-swiftui

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: AppScreen?
    
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ screen: AppScreen) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(_ screen: AppScreen) -> some View {
        switch screen {
        case .welcome: WelcomeScreen()
        case .register: RegisterScreen()
        case .login: LoginScreen()
        case .home: HomeScreen()
        case .addClient: AddClientScreen()
        }
    }
    
    @ViewBuilder
    func buildSheet(_ sheet: AppScreen) -> some View {
        switch sheet {
        case .addClient: AddClientScreen()
        default: HomeScreen()
        }
    }
}

enum AppScreen: String, Hashable, Identifiable {
    case welcome
    case register
    case login
    case home
    case addClient
    
    var id: String { self.rawValue }
    
    func shouldHideBackButton() -> Bool {
        switch self {
        case .home: true
        default: false
        }
    }
}
