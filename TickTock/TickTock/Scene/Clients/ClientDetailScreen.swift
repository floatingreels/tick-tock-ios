//
//  DetailClientScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ClientDetailScreen: View {
    
    @Environment(ClientStore.self) private var clientStore
    @Environment(ProjectStore.self) private var projectStore
    @Environment(Coordinator.self) private var coordinator
    
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
                    if let projects = clientStore.client?.projects, !projects.isEmpty {
                        projectsList
                    }
                    newProjectButton
                }
            }
            .padding(Spacing.interItem)
            .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)
        }
        .navigationTitle(Translation.Client.detailClientNavTitle.val)
        .onAppear(perform: projectStore.resetProjectDetail)
    }
}

private extension ClientDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.square.on.square.angled.fill", true))
    }
    
    var headerText: some View {
        Text(clientStore.client?.name ?? Translation.Error.general_message.val)
    }
    
    var projectsLabel: some View {
        Text(Translation.Client.detailClientProjectsLabel.val).bold()
    }
    
    var projectsList: some View {
        NavigatableList(items: clientStore.client?.projects ?? [], onSelection: didSelectProject)
            .frame(height: CGFloat(getProjectsCount()) > 3
                    ? Height.listItem * 3.5
                    : Height.listItem * CGFloat(getProjectsCount())
            )
    }
    
    var newProjectButton: some View {
        return NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addProject) },
            label: Translation.Client.detailClientNewProject.val
        )
        .accentColor(.labelLinks)
    }
    
    func didSelectProject(projectId: Int) {
        projectStore.getProjectDetail(projectId: projectId) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                coordinator.push(.detailProject)
            }
        }
    }
    
    func getProjectsCount() -> Int {
        (clientStore.client?.projects ?? []).count
    }
}
