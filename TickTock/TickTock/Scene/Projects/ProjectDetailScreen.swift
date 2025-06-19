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
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    @State private var project: Project?
    private let projectDetailData: ProjectDetailData
    private let requestManager = RequestManager.shared
    
    init(projectDetailData: ProjectDetailData) {
        self.projectDetailData = projectDetailData
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.interItem * 2) {
                CenteredHStack {
                    VStack(alignment: .center, spacing: Spacing.interItem) {
                        headerImage
                        headerText
                    }
                }
            }
            .padding(Spacing.interItem)
            .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)
        }
        .task { fetchProjectDetails() }
        .navigationTitle(Translation.Project.detailProjectNavTitle.val)
    }
}

private extension ProjectDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("text.document.fill", true))
    }
    
    var headerText: some View {
        Text(project?.name ?? Translation.Error.general_message.val)
    }
    
    func fetchProjectDetails() {
        requestManager.getProjectDetail(clientId: projectDetailData.clientId, projectId: projectDetailData.projectId) { [alertinator] data in
            switch data.result {
            case .success(let response):
                Task { @MainActor in
                    project = response.project
                }
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func buildTestProject() -> Project {
        Project(id: 2, clientId: 2, name: "Manhattan Project", rate: 12.33, rateTypeString: "hour", statusString: "active")
    }
}

#Preview {
    ProjectDetailScreen(projectDetailData: ProjectDetailData(clientId: Client.testClientId, projectId: 2))
}
