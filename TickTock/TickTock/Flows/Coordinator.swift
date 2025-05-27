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
    
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(_ screen: AppScreen) -> some View {
        
        switch screen {
        case .welcome: WelcomeScreen()
        case .register: RegisterScreen()
        case .login: LoginScreen()
        case .home: HomeScreen()
        }
    }
}

enum AppScreen: Hashable {
    case welcome
    case register
    case login
    case home
}
