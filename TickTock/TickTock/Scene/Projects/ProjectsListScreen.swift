//
//  ProjectsListScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectsListData: Hashable {
    let clientId: Int?
}

struct ProjectsListScreen: View {
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    @State private var projects: [Project] = []
    private let projectsData: ProjectsListData
    private let requestManager = RequestManager.shared
    
    init(projectsData: ProjectsListData) {
        self.projectsData = projectsData
    }
    
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            List(projects) { project in
                NavigatableListItem(action: {
                    goToDetail(projectId: project.id)
                }, label: {
                    Text(project.name)
                })
            }
            .scrollContentBackground(.hidden)
        }
        .task {
            fetchProjects()
        }
        .toolbar {
            ToolbarItem {
                toolBarButton
            }
        }
        .navigationTitle(Translation.Project.listProjectsNavTitle.val)
    }
}

private extension ProjectsListScreen {
    
    var toolBarButton: some View {
        NavigatableSheetPresenter(
            navigatable: {
                let data = ProjectCreateData(clientId: projectsData.clientId)
                NavigatableView(root: .addProject(data))
            },
            image: (name: ToolBarButtonType.add.rawValue, isSystem: true),
            dismissHandler: {
                fetchProjects()
            }
        )
        .accentColor(.labelLinks)
    }
    
    var headerImage: some View {
        HeaderImageView(image: ("document.on.document.fill", true))
    }
    
    func fetchProjects() {
        guard !isPreview else {
            projects = buildTestProjectsList()
            return
        }
        requestManager.getProjects(clientId: projectsData.clientId) { [alertinator] data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    projects = response.projects
                }
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func goToDetail(projectId: Int) {
        let data = ProjectDetailData(clientId: projectsData.clientId, projectId: projectId)
        coordinator.push(.detailProject(data))
    }
    
    func buildTestProjectsList() -> [Project] {
        [
            Project(id: 2, clientId: 2, name: "Manhattan Project", rate: 12.33, rateTypeString: "hour", statusString: "active"),
            Project(id: 3, clientId: 2, name: "Project X", rate: 111, rateTypeString: "week", statusString: "active"),
            Project(id: 4, clientId: 2, name: "Projection Rate", rate: 0.0, rateTypeString: "hour", statusString: "active")
        ]
    }
}

#Preview {
    ProjectsListScreen(projectsData: ProjectsListData(clientId: Client.testClientId))
}
