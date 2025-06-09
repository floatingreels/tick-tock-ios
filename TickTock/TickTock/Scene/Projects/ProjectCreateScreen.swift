//
//  ProjectCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectCreateData: Hashable {
    let clientId: Int
}

struct ProjectCreateScreen: View {
    
    private let testClientId = 9
    @EnvironmentObject private var coordinator: Coordinator
    @State private var projectName: String = ""
    @State private var isProjectNameValid: Bool? = nil
    @State private var rate: Double = 0
    @State private var rateType: RateType = .hour
    private let projectCreateData: ProjectCreateData
    
    init(projectCreateData: ProjectCreateData) {
        self.projectCreateData = projectCreateData
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
            VStack(alignment: .leading, spacing: Spacing.interItem) {
                projectNameLabel
                projectNameTextView
            }
            VStack(alignment: .leading, spacing: Spacing.interItem) {
                rateLabel
                HStack(spacing: Spacing.interItem) {
                    rateTextView
                        .containerRelativeFrame(.horizontal, alignment: .leading) { size, _ in
                        size / 3
                    }
                    rateTypePicker.layoutPriority(1)
                    Spacer()
                }
            }
            addProjectButton
            Spacer()
        }
        .navigationTitle(Translation.Project.addProjectNavTitle.val)
        .textFieldStyle(.roundedBorder)
        .padding(Spacing.interItem)
    }
}

private extension ProjectCreateScreen {
    var headerImage: some View {
        HeaderImageView(image: ("document.badge.plus.fill", true))
    }
    
    var headerText: some View {
        Text(Translation.Project.addProjectFormDescription.val)
    }
    
    var projectNameLabel: some View {
        Text(Translation.Project.projectNameLabel.val)
    }
    
    var projectNameTextView: some View {
        TextField(
            Translation.Project.projectNameLabel.val,
            text: $projectName,
            onEditingChanged: { isEdting in
                isProjectNameValid = isEdting ? nil : !projectName.isBlank
            },
            onCommit: {
                isProjectNameValid = !projectName.isBlank
            }
        )
        .textInputAutocapitalization(.never)
        .textContentType(.name)
        .keyboardType(.default)
        .submitLabel(.next)
    }
    
    var rateLabel: some View {
        Text(String("Your rate:"))
    }
    
    var rateTextView: some View {
        TextField(
            Translation.Project.projectRateLabel.val,
            value: $rate,
            format: .currency(code: "EUR"))
        .keyboardType(.decimalPad)
        .submitLabel(.next)
    }
    
    var rateTypePicker: some View {
        Menu {
            Picker("Charge frequency", selection: $rateType, content: {
                ForEach(RateType.allCases, content: { type in
                    Text(type.name)
                })
            })
        } label: {
            Text(rateType.name)
                .font(Font.body())
        }.id(rateType)
    }
    
    var addProjectButton: some View {
        Button(action: addProject) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!(isProjectNameValid ?? false))
    }
    
    func addProject() {
        RequestManager.shared.addProject(
            clientId: isPreview ? testClientId : projectCreateData.clientId,
            projectName: projectName,
            rate: rate,
            rateType: rateType
        ) { [coordinator] response in
            switch response.result {
            case .success:
                let data = GenericSuccessData(message: Translation.Project.addProjectSuccessMessage.val)
                coordinator.push(.success(data))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ProjectCreateScreen(projectCreateData: ProjectCreateData(clientId: 9))
}
