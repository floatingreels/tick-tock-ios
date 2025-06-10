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
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            List(clients) { client in
                NavigatableListItem(action: {
                    goToDetail(clientId: client.id)
                }, label: {
                    Text(client.name)
                })
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .task {
            fetchClients()
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
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
        HeaderImageView(image: ("person.3.sequence.fill", true))
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
            Client(id: 2, name: "Anicura", userId: TickTockDefaults.shared.userId),
            Client(id: 3, name: "Den Boom", userId: TickTockDefaults.shared.userId),
            Client(id: 4, name: "Pet Sematary", userId: TickTockDefaults.shared.userId),
            Client(id: 5, name: "Dawg Life", userId: TickTockDefaults.shared.userId)
        ]
    }
}

#Preview {
    ClientsListScreen()
}
