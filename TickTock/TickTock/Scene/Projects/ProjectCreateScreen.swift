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
                        switch clientStore.clients.count {
                        case 0, 1:
                            clientsLabel
                            addClientButton
                        default:
                            HStack {
                                clientsLabel
                                Spacer()
                                addClientButton
                            }
                            clientsList
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
    }
    
    var clientsLabel: some View {
        let label = Translation.Project.addProjectClientLabel.val
        if clientStore.clients.count == 1 {
            clientId = clientStore.clients[0].id
            return Text("\(label): \(clientStore.clients[0].name)").bold()
        } else if let id = clientId,
           let client = clientStore.clients.first(where: { $0.id == id }) {
            return Text("\(label): \(client.name)").bold()
        } else {
            return Text(label).bold()
        }
        
    }
    
    var clientsList: some View {
        return SingleSelectionList<Client>(items: clientStore.clients, selectedItemId: $clientId)
            .frame(height: CGFloat(clientStore.clients.count) > 2
                   ? Height.listItem * 2.5
                   : Height.listItem * CGFloat(clientStore.clients.count)
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
        Text(Translation.Project.projectNameLabel.val).bold()
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
        Text(String("Your rate:")).bold()
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
