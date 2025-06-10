//
//  DetailClientScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ClientDetailData: Hashable {
    let clientId: Int
}

struct ClientDetailScreen: View {
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    @State private var client: Client?
    private let clientDetailData: ClientDetailData
    private let requestManager = RequestManager.shared
    
    init(clientDetailData: ClientDetailData) {
        self.clientDetailData = clientDetailData
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
        }
        .task {
            fetchClientDetails()
        }
        .navigationTitle(Translation.Client.detailClientNavTitle.val)
        .padding(Spacing.interItem)
    }
}

private extension ClientDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.square.on.square.angled.fill", true))
    }
    
    var headerText: some View {
        Text(client?.name ?? Translation.Error.general_message.val)
    }
    
    func fetchClientDetails() {
        guard !isPreview else {
            client = buildTestClient()
            return
        }
        requestManager.getClientDetail(clientId: clientDetailData.clientId) { [alertinator] data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    client = response.client
                }
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func buildTestClient() -> Client {
        Client(id: 4, name: "Pet Sematary", userId: TickTockDefaults.shared.userId)
    }
}

#Preview {
    ClientDetailScreen(clientDetailData: ClientDetailData(clientId: Client.testClientId))
}
