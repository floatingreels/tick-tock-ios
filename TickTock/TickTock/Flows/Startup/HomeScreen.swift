//
//  HomeScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            if let first =  TickTockDefaults.shared.firstName,
               let last = TickTockDefaults.shared.lastName {
                Text("Hello, \(first) \(last)!")
            } else {
                Text(isPreview ? "Hello, Joe Tester!" : "Something went wrong")
            }
            VStack(spacing: Spacing.interItem) {
                addClientButton
                newProjectButton
                startSessionButton
            }
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .navigationTitle(Translation.Startup.homeNavTitle.val)
    }
}

private extension HomeScreen {
    
    var toolBarButton: some View {
        Button(action: logout) {
            Image(systemName: ToolBarButtonType.settings.rawValue)
        }
    }
    var addClientButton: some View {
        Button(action: addClient) {
            Text(Translation.Startup.buttonAddClient.val)
        }
        .accentColor(.labelLinks)
    }
    
    var newProjectButton: some View {
        Button(action: newProject) {
            Text(Translation.Startup.buttonNewProject.val)
        }
        .accentColor(.labelLinks)
    }
    
    var startSessionButton: some View {
        Button(action: startSession) {
            Text(Translation.Startup.buttonStartSession.val)
        }
        .accentColor(.labelLinks)
    }
    
    func addClient() {
        coordinator.push(.addClient)
    }
    
    func newProject() {
    }
    
    func startSession() {
    }
    
    func logout() {
        HousekeepingManager.shared.logout()
        coordinator.popToRoot()
    }
}

#Preview {
    HomeScreen()
}
