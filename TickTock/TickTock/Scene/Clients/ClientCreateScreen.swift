//
//  ClientCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 29/05/2025.
//

import SwiftUI

struct ClientCreateScreen: View {
    
    @Environment(ClientStore.self) private var clientStore
    @Environment(Alertinator.self) private var alertinator
    @Environment(Coordinator.self) private var coordinator
    @State private var companyName: String = ""
    @State private var isClientNameValid: Bool? = nil
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            CenteredHStack {
                VStack(alignment: .center, spacing: Spacing.interItem) {
                    headerImage
                    headerText
                }
            }
            VStack(alignment: .leading, spacing: Spacing.interItem) {
                clientNameLabel
                clientNameTextView
            }
            CenteredHStack {
                addClientButton
            }
            Spacer()
        }
        .navigationTitle(Translation.Client.addClientNavTitle.val)
        .padding(Spacing.interItem)
    }
}

private extension ClientCreateScreen {
        
    var headerImage: some View {
        HeaderImageView(image: ("person.2.badge.plus.fill", true))
    }
    
    var headerText: some View {
        Text(Translation.Client.addClientFormDescription.val)
    }
    
    var clientNameLabel: some View {
        Text(Translation.Client.clientNameLabel.val).bold()
    }
    
    var clientNameTextView: some View {
        TextField(
            Translation.Client.clientNameLabel.val,
            text: $companyName,
            onEditingChanged: { isEdting in
                isClientNameValid = isEdting ? nil : !companyName.isBlank
            },
            onCommit: {
                isClientNameValid = !companyName.isBlank
            }
        )
        .textInputAutocapitalization(.never)
        .textContentType(.organizationName)
        .keyboardType(.default)
        .submitLabel(.done)
    }
    
    var addClientButton: some View {
        Button(action: didPressAddClient) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!(isClientNameValid ?? false))
    }
    
    func didPressAddClient() {
        clientStore.addClient(companyName: companyName) { error in
            if let error {
                alertinator.presentAlert(error)
            } else {
                let success = GenericSuccessData(message: Translation.Client.addClientSuccessMessage.val)
                coordinator.push(.success(success))
            }
        }
    }
}

#Preview {
    ClientCreateScreen()
}
