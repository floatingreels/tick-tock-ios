//
//  ProjectCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectCreateScreen: View {
    
    @Environment(StoreManager.self) private var storeManager
    @Environment(ClientStore.self) private var clientStore
    @Environment(Coordinator.self) private var coordinator
    @FocusState private var inFocus: InputFieldType?
    @State private var clientId: Int?
    @State private var projectName: String = ""
    @State private var rate: Double = 0
    @State private var rateType: RateType = .hour
    private let fieldSequence: [InputFieldType] = [.projectName, .rate]
    
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
                    projectNameLabel
                    projectNameTextView
                }
                if clientStore.client == nil {
                    VStack(alignment: .leading, spacing: Spacing.interItem) {
                        if isPreview || clientStore.clients.count > 1 {
                            HStack {
                                clientsLabel
                                Spacer()
                                addClientButton
                            }
                            clientsList
                        } else {
                            clientsLabel
                            addClientButton
                        }
                    }
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
                CenteredHStack {
                    addProjectButton
                }
                Spacer()
            }
            .padding(.horizontal, Spacing.interItem)
            .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)
        }
        .navigationTitle(Translation.Project.addProjectNavTitle.val)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { inFocus = .projectName })
        }
    }
}

private extension ProjectCreateScreen {
    
    var headerImage: some View {
        return HeaderImageView(image: ("document.badge.plus.fill", true))
    }
    
    var headerText: some View {
        Text(Translation.Project.addProjectFormDescription.val)
            .font(Font.body())
    }
    
    var clientsLabel: some View {
        var label = Translation.Project.addProjectClientLabel.val
        if isSoleClient() {
            label = "\(label): \(clientStore.clients[0].name)"
        } else if let id = clientId,
           let client = clientStore.clients.first(where: { $0.id == id }) {
            label = "\(label): \(client.name)"
        }
        return Text(label)
            .font(Font.title3(weight: .bold))
        
    }
    
    var clientsList: some View {
        let items = isPreview
            ? ClientStore.buildTestClients().asSelectable()
            : clientStore.clients.asSelectable()
        return SingleSelectionList<ClientCellData>(items: items, selectedItemId: $clientId)
            .frame(height: CGFloat(items.count) > 2
                   ? Height.listItem * 2.5
                   : Height.listItem * CGFloat(items.count)
            )
    }
    
    var addClientButton: some View {
        NavigatableSheetPresenter(
            navigatable: { NavigatableView(root: .addClient) },
            label: Translation.Project.addProjectNewClientButton.val
        )
        .accentColor(.labelLinks)
    }
    
    var projectNameLabel: some View {
        Text(Translation.Project.projectNameLabel.val)
            .font(Font.title3(weight: .bold))
    }
    
    var projectNameTextView: some View {
        CustomTextField(inputFieldType: .projectName, inFocus: $inFocus, text: $projectName, fieldSequence: fieldSequence)
    }
    
    var rateLabel: some View {
        Text(String("Your rate:"))
            .font(Font.title3(weight: .bold))
    }
    
    var rateTextView: some View {
        CustomTextField(inputFieldType: .rate, inFocus: $inFocus, value: $rate, fieldSequence: fieldSequence)
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
        Button(action: didPressAddProject) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isFormValid())
        .onAppear { updateClientId() }
        .onChange(of: clientStore.clients.count) { _, _ in updateClientId() }
    }
    
    func didPressAddProject() {
        guard let clientId = getClientId() else {
            coordinator.presentAlert(CustomAlert.generalError())
            return
        }
        storeManager.addProject(
            clientId: clientId,
            projectName: projectName,
            rate: rate,
            rateType: rateType
        ) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                let success = GenericSuccessData(message: Translation.Project.addProjectSuccessMessage.val)
                coordinator.push(.success(success))
            }
        }
    }
    
    func isSoleClient() -> Bool {
        return clientStore.clients.count == 1
    }
    
    private func updateClientId() {
        if isSoleClient() {
            clientId = clientStore.clients.first?.id
        }
    }
    
    func getClientId() -> Int? {
        clientId ?? clientStore.client?.id
    }
    
    func isFormValid() -> Bool {
        guard let clientId = getClientId() else { return false }
        let valid = !projectName.isBlank && rate >= 0.0
        print("project name = \(projectName)\nrate = \(rate)\nclientId = \(clientId)\n\n\n")
        return valid
    }
}

#Preview {
    ProjectCreateScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(StoreManager(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
