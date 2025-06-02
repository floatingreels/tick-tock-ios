//
//  AddClientScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 29/05/2025.
//

import SwiftUI

struct AddClientScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var clientName: String = ""
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
        .textFieldStyle(.roundedBorder)
    }
}

private extension AddClientScreen {
        
    var headerImage: some View {
        Image(systemName: "person.fill.badge.checkmark")
            .resizable()
            .frame(width: Size.detailHeaderLogo, height: Size.detailHeaderLogo)
    }
    
    var headerText: some View {
        Text(Translation.Startup.loginFormDescription.val)
    }
    
    var clientNameTextView: some View {
        TextField(
            Translation.Client.clientNameLabel.val,
            text: $clientName,
            onEditingChanged: { isEdting in
                isClientNameValid = isEdting ? nil : !clientName.isBlank
            },
            onCommit: {
                isClientNameValid = !clientName.isBlank
            }
        )
        .textInputAutocapitalization(.never)
        .textContentType(.organizationName)
        .keyboardType(.default)
        .submitLabel(.done)
    }
    
    var addClientButton: some View {
        Button(action: addClient) {
            Text(String("Add client"))
                .textContentType(.givenName)
        }
        .accentColor(.labelLinks)
        .disabled(!(isClientNameValid ?? false))
    }
    
    func addClient() {
        RequestManager.shared.addClient(clientName: clientName) { [coordinator] response in
            switch response.result {
            case .success:
                coordinator.pop()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AddClientScreen()
}
