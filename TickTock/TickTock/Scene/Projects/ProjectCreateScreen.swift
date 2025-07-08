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
    @State private var clientId: Int?
    @State private var projectName: String = ""
    @State private var isProjectNameValid: Bool? = nil
    @State private var rate: Double = 0
    @State private var rateType: RateType = .hour
    
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
        if clientStore.clients.count == 1 {
            clientId = clientStore.clients[0].id
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
            ? ClientStore.buildTestClients()
            : clientStore.clients
        return SingleSelectionList<Client>(items: items, selectedItemId: $clientId)
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
            .font(Font.title3(weight: .bold))
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
        Button(action: didPressAddProject) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isFormValid())
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
    
    func getClientId() -> Int? {
        clientId ?? clientStore.client?.id
    }
    
    func isFormValid() -> Bool {
        isProjectNameValid == true && getClientId() != nil
    }
}

#Preview {
    ProjectCreateScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(StoreManager(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
