//
//  ProjectsListScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectsListData: Hashable {
    let clientId: Int
}

struct ProjectsListScreen: View {
    
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
        requestManager.getProjects(clientId: projectsData.clientId) { data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    projects = response.projects
                }
            case .failure(_): fatalError()
            }
        }
    }
    
    func goToDetail(projectId: Int) {
        print(#function)
    }
}

#Preview {
    ProjectsListScreen(projectsData: ProjectsListData(clientId: 5))
}
