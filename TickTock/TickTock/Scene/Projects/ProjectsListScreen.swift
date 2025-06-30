//
//  ProjectsListScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectsListScreen: View {
    
    @Environment(ClientStore.self) private var clientStore
    @Environment(ProjectStore.self) private var projectStore
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            projectsList
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .padding(Spacing.interItem)
        .navigationTitle(Translation.Project.listProjectsNavTitle.val)
        .onAppear(perform: projectStore.resetProjectDetail)
    }
}

private extension ProjectsListScreen {
    
    var toolBarButton: some View {
        NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addProject) },
            image: (name: ToolBarButtonType.add.rawValue, isSystem: true),
            presentHandler: didPressCreateProject
        )
            .accentColor(.labelLinks)
    }
    
    var headerImage: some View {
        HeaderImageView(image: ("document.on.document.fill", true))
    }
    
    var projectsList: some View  {
        NavigatableList(items: isPreview ? testProjects : projectStore.projects, onSelection: didSelectProject)
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
    
    func didPressCreateProject() {
        clientStore.getAllClients { _ in }
    }
}

#Preview {
    ProjectsListScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(ProjectStore(requestManager: RequestManager.shared))
        .environment(Coordinator())
}

private extension ProjectsListScreen {
    var testProjects: [Project] {
        [
            Project(id: 1, clientId: 1, name: "First Project", rate: 1800, rateTypeString: "week", statusString: "active"),
            Project(id: 2, clientId: 1, name: "Project X", rate: 31.2, rateTypeString: "hour", statusString: "active"),
            Project(id: 3, clientId: 2, name: "Manhattan Project", rate: 4771, rateTypeString: "month", statusString: "active"),
            Project(id: 4, clientId: 3, name: "The Projects", rate: 66.6, rateTypeString: "hour", statusString: "active"),
            Project(id: 5, clientId: 3, name: "Pro Geny", rate: 500, rateTypeString: "day", statusString: "active"),
            Project(id: 6, clientId: 3, name: "Astral Projection", rate: 72, rateTypeString: "hour", statusString: "active"),
            Project(id: 7, clientId: 5, name: "P.R.O.J.E.C.T", rate: 420, rateTypeString: "day", statusString: "active"),
            Project(id: 8, clientId: 5, name: "The Jects", rate: 2250, rateTypeString: "week", statusString: "active")
        ]
    }
}
