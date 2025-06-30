//
//  Coordinator.swift
//  TickTock
//
//  Created by David Gunzburg on 25/05/2025.
//  Thanks to: https://www.swiftanytime.com/blog/coordinator-pattern-in-swiftui

import SwiftUI

@Observable
final class Coordinator {
    
    var path = NavigationPath()
    var sheet: AppScreen?
    var alert: CustomAlert?
    
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
    
    func presentAlert(_ alert: CustomAlert) {
        self.alert = alert
    }
    
    func dismissAlert() {
        self.alert = nil
    }
    
    @ViewBuilder func buildScreen(_ screen: AppScreen) -> some View {
        switch screen {
        case .welcome: WelcomeScreen()
        case .register: RegisterScreen()
        case .login: LoginScreen()
        case .home: HomeScreen()
        case .addClient: ClientCreateScreen()
        case .success(let data): GenericSuccessScreen(data: data)
        case .listClients: ClientsListScreen()
        case .detailClient: ClientDetailScreen()
        case .addProject: ProjectCreateScreen()
        case .listProjects: ProjectsListScreen()
        case .detailProject: ProjectDetailScreen()
        }
    }
    
    @ViewBuilder func buildSheet(_ sheet: AppScreen) -> some View {
        switch sheet {
        case .addClient: ClientCreateScreen()
        default: HomeScreen()
        }
    }
}
