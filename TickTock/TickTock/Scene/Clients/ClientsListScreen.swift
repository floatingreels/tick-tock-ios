//
//  ListClientsScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 04/06/2025.
//

import SwiftUI

struct ClientsListScreen: View {
    
    @Environment(Coordinator.self) private var coordinator
    @Environment(ClientStore.self) private var clientStore
    
    var body: some View {
        VStack(spacing: Spacing.interItem) {
            headerImage
            clientsList
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .padding(.horizontal, Spacing.interItem)
        .navigationTitle(Translation.Client.listClientsNavTitle.val)
        .onAppear(perform: clientStore.resetClientDetail)
    }
}

private extension ClientsListScreen {
    
    var toolBarButton: some View {
        NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addClient) },
            image: (name: ToolBarButtonType.add.rawValue, isSystem: true)
        )
        .accentColor(.labelLinks)
    }
    
    var headerImage: some View {
        HeaderImageView(image: ("person.2.fill", true))
    }
    
    var clientsList: some View  {
        let items = isPreview
            ? ClientStore.buildTestClients().asSelectable()
            : clientStore.clients.asSelectable()
        return NavigatableList(items: items, onSelection: didSelectClient)
    }
    
    func didSelectClient(clientId: Int) {
        clientStore.getClientDetail(clientId: clientId) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                coordinator.push(.detailClient)
            }
        }
    }
}

#Preview {
    ClientsListScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
