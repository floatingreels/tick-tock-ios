//
//  ProjectDetailScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 09/06/2025.
//

import SwiftUI

struct ProjectDetailScreen: View {
    
    @Environment(SessionStore.self) private var sessionStore
    @Environment(ProjectStore.self) private var projectStore
    @Environment(Coordinator.self) private var coordinator
    let testProjectId = Int.random(in: 1...10)
    
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
                    sessionsLabel
                    if isPreview {
                        sessionsList
                    } else if let sessions = projectStore.project?.sessions,
                           !sessions.isEmpty {
                        sessionsList
                    }
                    newSessionButton
                }
                Spacer()
            }
            .padding(Spacing.interItem)
            .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)
        }
        .navigationTitle(Translation.Project.detailProjectNavTitle.val)
    }
}

private extension ProjectDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("text.document.fill", true))
    }
    
    var headerText: some View {
        let name = isPreview
            ? ProjectStore.buildTestProjects().first(where: { $0.id == testProjectId })?.name
            : projectStore.project?.name
        return Text(name ?? Translation.Error.general_message.val)
    }
    
    var sessionsLabel: some View {
        Text(Translation.Project.detailProjectSessionsLabel.val)
            .font(Font.title3(weight: .bold))
    }
    
    var sessionsList: some View {
        let items = isPreview
            ? SessionStore.buildTestSessions().filter { $0.projectId == testProjectId }
            : projectStore.project?.sessions ?? []
        return NavigatableList(items: items, onSelection: didSelectSession)
            .frame(height: CGFloat(items.count) > 3
                   ? Height.listItem * 3.5
                   : Height.listItem * CGFloat(items.count)
            )
    }
    
    var newSessionButton: some View {
        return NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .activeSession) },
            label: Translation.Project.detailProjectStartSession.val
        )
        .accentColor(.labelLinks)
    }
    
    func didSelectSession(sessionId: Int) {
        guard let project = projectStore.project,
              let clientId = project.clientId
        else { return }
        sessionStore.getSessionDetail(clientId: clientId, projectId: project.id, sessionId: sessionId) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                coordinator.push(.detailProject)
            }
        }
    }
}

#Preview {
    ProjectDetailScreen()
        .environment(SessionStore(requestManager: RequestManager.shared))
        .environment(ProjectStore(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
