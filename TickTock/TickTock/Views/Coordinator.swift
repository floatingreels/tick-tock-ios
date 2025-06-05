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
        self.sheet = screen
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func buildScreen(_ screen: AppScreen) -> some View {
        switch screen {
        case .welcome: WelcomeScreen()
        case .register: RegisterScreen()
        case .login: LoginScreen()
        case .home: HomeScreen()
        case .addClient: AddClientScreen()
        case .success(let data): SuccessScreen(data: data)
        case .listClients: ListClientsScreen()
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
