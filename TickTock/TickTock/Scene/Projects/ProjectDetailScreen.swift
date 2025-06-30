//
//  ProjectDetailScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 09/06/2025.
//

import SwiftUI

struct ProjectDetailScreen: View {
    
    @Environment(ProjectStore.self) private var projectStore
    @Environment(Coordinator.self) private var coordinator
    
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
        .navigationTitle(Translation.Project.detailProjectNavTitle.val)
    }
}

private extension ProjectDetailScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("text.document.fill", true))
    }
    
    var headerText: some View {
        Text(projectStore.project?.name ?? Translation.Error.general_message.val)
    }
}
