//
//  ProjectDetailScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 09/06/2025.
//

import SwiftUI

struct ProjectDetailData: Hashable {
    let clientId: Int
    let projectId: Int
}

struct ProjectDetailScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var project: Project?
    private let projectDetailData: ProjectDetailData
    private let requestManager = RequestManager.shared
    
    init(projectDetailData: ProjectDetailData) {
        self.projectDetailData = projectDetailData
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
        }
        .task {
            fetchProjectDetails()
        }
        .navigationTitle(Translation.Project.detailProjectNavTitle.val)
        .padding(Spacing.interItem)
    }
}

private extension ProjectDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("document.badge.plus.fill", true))
    }
    
    var headerText: some View {
        Text(project?.name ?? Translation.Error.general.val)
    }
    
    func fetchProjectDetails() {
        print(#function)
        requestManager.getProjectDetail(clientId: projectDetailData.clientId, projectId: projectDetailData.projectId) { data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    project = response.project
                }
            case .failure(_): fatalError()
            }
        }
    }
}

#Preview {
    ProjectDetailScreen(projectDetailData: ProjectDetailData(clientId: 1, projectId: 2))
}
