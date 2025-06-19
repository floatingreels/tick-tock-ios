//
//  ProjectCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct ProjectCreateData: Hashable {
    let clientId: Int?
}

struct ProjectCreateScreen: View {
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    @State private var projectName: String = ""
    @State private var isProjectNameValid: Bool? = nil
    @State private var clients: [Client] = []
    @State private var rate: Double = 0
    @State private var rateType: RateType = .hour
    @State private var clientId: Int?
    private let projectCreateData: ProjectCreateData
    
    init(projectCreateData: ProjectCreateData) {
        self.projectCreateData = projectCreateData
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
                VStack(alignment: .leading, spacing: Spacing.interItem) {
                    projectNameLabel
                    projectNameTextView
                }
                if projectCreateData.clientId == nil {
                    VStack(alignment: .leading, spacing: Spacing.interItem) {
                        switch clients.count {
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
                    .task {
                        if clientId == nil {
                            getClients()
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
        guard let id = clientId, let client = clients.first(where: { $0.id == id })  else  {
            return Text(label).bold()
        }
        return Text("\(label): \(client.name)").bold()
    }
    
    var clientsList: some View {
        return SingleSelectionList<Client>(items: clients, selectedItemId: $clientId)
            .frame(height: CGFloat(clients.count) > 2 ?  44 * 2.5 : 44 * CGFloat(clients.count))
    }
    
    var addClientButton: some View {
        NavigatableSheetPresenter(
            navigatable: {
                NavigatableView(root: .addClient)
            },
            label: Translation.Project.addProjectNewClientButton.val,
            dismissHandler: getClients
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
        Button(action: addProject) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!(isProjectNameValid ?? false))
    }
    
    func getClients() {
        if isPreview {
            clients = buildTestClientsList()
        } else {
            RequestManager.shared.getClients { [alertinator] data in
                switch data.result {
                case .success(let response):
                    Task { @MainActor in
                        if response.clients.count == 1 {
                            self.clientId = response.clients[0].id
                        }
                        clients = response.clients
                    }
                case .failure(let error):
                    alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
                }
            }
        }
    }
    
    func addProject() {
        guard let clientId = clientId ?? projectCreateData.clientId else {
            alertinator.presentAlert(CustomAlert.generalError())
            return
        }
        RequestManager.shared.addProject(
            clientId: isPreview ? Client.testClientId : clientId,
            projectName: projectName,
            rate: rate,
            rateType: rateType
        ) { [alertinator, coordinator] data in
            switch data.result {
            case .success:
                let success = GenericSuccessData(message: Translation.Project.addProjectSuccessMessage.val)
                coordinator.push(.success(success))
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func buildTestClientsList() -> [Client] {
        [
            Client(id: 2, name: "Anicura", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 3, name: "Den Boom", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 4, name: "Pet Sematary", projects: [], userId: TickTockDefaults.shared.userId),
            Client(id: 5, name: "Dawg Life", projects: [], userId: TickTockDefaults.shared.userId)
        ]
    }
}

#Preview {
    ProjectCreateScreen(projectCreateData: ProjectCreateData(clientId: nil))
}
