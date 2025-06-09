//
//  ListClientsScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 04/06/2025.
//

import SwiftUI

struct ClientsListScreen: View {

    @EnvironmentObject private var coordinator: Coordinator
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

        requestManager.getClients() { data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    clients = response.clients
                }
            case .failure(_): fatalError()
            }
        }
    }
    
    func goToDetail(clientId: Int) {
        let data = ClientDetailData(clientId: clientId)
        coordinator.push(.detailClient(data))
    }
}

#Preview {
    ClientsListScreen()
}
