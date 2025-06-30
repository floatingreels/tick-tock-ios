//
//  HomeScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 27/05/2025.
//

import SwiftUI

struct HomeScreen: View {
    
    private let testDismissLog = "Testing dismiss handler on sheet"
    @Environment(AuthStore.self) private var authStore
    @Environment(ProjectStore.self) private var projectStore
    @Environment(ClientStore.self) private var clientStore
    @Environment(Coordinator.self) private var coordinator
    
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
        .onAppear {
            clientStore.resetAll()
            projectStore.resetAll()
        }
    }
}

private extension HomeScreen {
    
    var toolBarButton: some View {
        Button(action: logout) {
            Image(systemName: ToolBarButtonType.settings.rawValue)
        }
    }
    var listClientsButton: some View {
        Button(action: didPressClientsList) {
            Text(Translation.Startup.buttonListClients.val)
        }
        .accentColor(.labelLinks)
    }
    var addClientButton: some View {
        NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addClient) },
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
        return NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addProject) },
            label: Translation.Startup.buttonNewProject.val,
            presentHandler: didPressCreateProject
        )
        .accentColor(.labelLinks)
    }
    
    var startSessionButton: some View {
        Button(action: startSession) {
            Text(Translation.Startup.buttonStartSession.val)
        }
        .accentColor(.labelLinks)
    }
    
    func didPressClientsList() {
        clientStore.getAllClients { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                coordinator.push(.listClients)
            }
        }
    }
    
    func didPressCreateProject() {
        clientStore.getAllClients { _ in }
    }
    
    func showProjectsList() {
        projectStore.getAllProjects { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                coordinator.push(.listProjects)
            }
        }
    }
    
    func startSession() {
        print(#function)
    }
    
    func logout() {
        authStore.logout()
        coordinator.popToRoot()
    }
}

#Preview {
    HomeScreen()
}
