//
//  ClientCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 29/05/2025.
//

import SwiftUI

struct ClientCreateScreen: View {
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    @State private var companyName: String = ""
    @State private var isClientNameValid: Bool? = nil
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
            VStack(spacing: Spacing.interItem / 2) {
                clientNameTextView
            }
            addClientButton
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
        Button(action: addClient) {
            Text(Translation.General.buttonCreate.val)  
        }
        .accentColor(.labelLinks)
        .disabled(!(isClientNameValid ?? false))
    }
    
    func addClient() {
        RequestManager.shared.addClient(companyName: companyName) { [alertinator, coordinator] data in
            switch data.result {
            case .success:
                let success = GenericSuccessData(message: Translation.Client.addClientSuccessMessage.val)
                coordinator.push(.success(success))
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
}

#Preview {
    ClientCreateScreen()
}
