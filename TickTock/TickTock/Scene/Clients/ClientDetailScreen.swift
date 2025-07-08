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
    let testClientId = Int.random(in: 1...5)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.interItem * 2) {
                CenteredHStack {
                    VStack(alignment: .center, spacing: Spacing.interItem) {
                        headerImage
                        headerText
                    }
                }
                VStack(alignment: .leading, spacing: Spacing.interItem) {
                    projectsLabel
                    if isPreview {
                        projectsList
                    } else if let projects = clientStore.client?.projects, !projects.isEmpty {
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
        let name =  isPreview
            ? ClientStore.buildTestClients().first(where: { $0.id == testClientId })?.name
            : clientStore.client?.name
        return Text(name ?? Translation.Error.general_message.val)
    }
    
    var projectsLabel: some View {
        Text(Translation.Client.detailClientProjectsLabel.val)
            .font(Font.title3(weight: .bold))
    }
    
    var projectsList: some View {
        var items: [ProjectCellData] = []
        if isPreview {
            items.append(contentsOf: ProjectStore.buildTestProjects()
                .filter({ $0.clientId == testClientId })
                .asSelectable())
        } else {
            items.append(contentsOf: clientStore.client?.projects?.asSelectable() ?? [])
        }
        return NavigatableList(items: items, onSelection: didSelectProject)
            .frame(height: CGFloat(items.count) > 3
                    ? Height.listItem * 3.5
                    : Height.listItem * CGFloat(items.count)
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
}

#Preview {
    ClientDetailScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(ProjectStore(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
