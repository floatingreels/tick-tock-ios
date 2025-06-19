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
        ScrollView {
            VStack(spacing: Spacing.interItem * 2) {
                CenteredHStack {
                    VStack(alignment: .center, spacing: Spacing.interItem) {
                        headerImage
                        headerText
                    }
                }
                VStack(alignment: .leading, spacing: Spacing.interItem) {
                    projectsLabel
                    if let projects = client?.projects, !projects.isEmpty {
                        projectsList
                            .listStyle(.insetGrouped)
                            .scrollContentBackground(.hidden)
                    }
                    newProjectButton
                }
                Spacer()
            }
            .padding(Spacing.interItem)
            .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)
        }
        .task { fetchClientDetails() }
        .navigationTitle(Translation.Client.detailClientNavTitle.val)
    }
}

private extension ClientDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.square.on.square.angled.fill", true))
    }
    
    var headerText: some View {
        Text(client?.name ?? Translation.Error.general_message.val)
    }
    
    var projectsLabel: some View {
        Text(Translation.Client.detailClientProjectsLabel.val)
    }
    
    var projectsList: some View {
        NavigatableList(items: client?.projects ?? [], onSelection: goToProjectDetail)
    }
    
    var newProjectButton: some View {
        let data = ProjectCreateData(clientId: clientDetailData.clientId)
        return NavigatableSheetPresenter(
            navigatable: {
                NavigatableView(root: .addProject(data))
            },
            label: Translation.Client.detailClientNewProject.val,
            dismissHandler: fetchClientDetails
        )
        .accentColor(.labelLinks)
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
        
    func goToProjectDetail(projectId: Int) {
        let data = ProjectDetailData(clientId: clientDetailData.clientId, projectId: projectId)
        coordinator.push(.detailProject(data))
    }
    
    func buildTestClient() -> Client {
        Client(id: 4, name: "Pet Sematary", projects: [], userId: TickTockDefaults.shared.userId)
    }
}

#Preview {
    ClientDetailScreen(clientDetailData: ClientDetailData(clientId: Client.testClientId))
}
