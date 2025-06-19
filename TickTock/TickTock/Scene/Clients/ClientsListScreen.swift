//
//  ListClientsScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 04/06/2025.
//

import SwiftUI

struct ClientsListScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var alertinator: Alertinator
    @State private var clients: [Client] = []
    private let requestManager = RequestManager.shared
    
    var body: some View {
        VStack(spacing: Spacing.interItem) {
            headerImage
            clientsList
        }
        .task {
            fetchClients()
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .padding(.horizontal, Spacing.interItem)
        .navigationTitle(Translation.Client.listClientsNavTitle.val)
    }
}

private extension ClientsListScreen {
    
    var toolBarButton: some View {
        NavigatableSheetPresenter(
            navigatable: {
                NavigatableView(root: .addClient)
            },
            image: (name: ToolBarButtonType.add.rawValue, isSystem: true),
            dismissHandler: {
                fetchClients()
            }
        )
        .accentColor(.labelLinks)
    }
    
    var headerImage: some View {
        HeaderImageView(image: ("person.2.fill", true))
    }
    
    var clientsList: some View  {
        NavigatableList(items: clients, onSelection: goToDetail)
    }
    
    func fetchClients() {
        guard !isPreview else {
            clients = buildTestClientsList()
            return
        }
        requestManager.getClients() { [alertinator] data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    clients = response.clients
                }
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func goToDetail(clientId: Int) {
        let data = ClientDetailData(clientId: clientId)
        coordinator.push(.detailClient(data))
    }
    
    func buildTestClientsList() -> [Client] {
        [
            Client(id: 2, name: "Anicura", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 3, name: "Den Boom", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 4, name: "Pet Sematary", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 5, name: "Dawg Life", projects: [], userId: TickTockDefaults.shared.userId)
        ]
    }
}

#Preview {
    ClientsListScreen()
}
