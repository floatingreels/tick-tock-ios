//
//  HomeScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

struct HomeScreen: View {
    
    private let testDismissLog = "Testing dismiss handler on sheet"
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.interItem * 4) {
                if let first =  TickTockDefaults.shared.firstName,
                   let last = TickTockDefaults.shared.lastName {
                    Text("Hello, \(first) \(last)!")
                } else {
                    Text(isPreview ? "Hello, Joe Tester!" : Translation.Error.general_message.val)
                }
                VStack(spacing: Spacing.interItem * 3) {
                    HStack(spacing: Spacing.interItem * 3) {
                        listClientsButton
                        addClientButton
                    }
                    HStack(spacing: Spacing.interItem * 3) {
                        listProjectsButton
                        newProjectButton
                    }
                    startSessionButton
                }
            }
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .navigationTitle(Translation.Startup.homeNavTitle.val)
        .padding(Spacing.interItem)
    }
}

private extension HomeScreen {
    
    var toolBarButton: some View {
        Button(action: logout) {
            Image(systemName: ToolBarButtonType.settings.rawValue)
        }
    }
    var listClientsButton: some View {
        Button(action: showClientsList) {
            Text(Translation.Startup.buttonListClients.val)
        }
        .accentColor(.labelLinks)
    }
    var addClientButton: some View {
        NavigatableSheetPresenter(
            navigatable: {
                NavigatableView(root: .addClient)
            },
            label: Translation.Startup.buttonAddClient.val)
        .accentColor(.labelLinks)
    }
    var listProjectsButton: some View {
        Button(action: showProjectsList) {
            Text(Translation.Startup.buttonListProjects.val)
        }
        .accentColor(.labelLinks)
    }
    var newProjectButton: some View {
        let data = ProjectCreateData(clientId: nil)
        return NavigatableSheetPresenter(
            navigatable: {
                NavigatableView(root: .addProject(data))
            },
            label: Translation.Startup.buttonNewProject.val)
        .accentColor(.labelLinks)
    }
    
    var startSessionButton: some View {
        Button(action: startSession) {
            Text(Translation.Startup.buttonStartSession.val)
        }
        .accentColor(.labelLinks)
    }
    
    func showClientsList() {
        coordinator.push(.listClients)
    }
    
    func showProjectsList() {
        let data = ProjectsListData(clientId: nil)
        coordinator.push(.listProjects(data))
    }
    
    func startSession() {
        print(#function)
    }
    
    func logout() {
        AuthManager.shared.logout()
        coordinator.popToRoot()
    }
}

#Preview {
    HomeScreen()
}
