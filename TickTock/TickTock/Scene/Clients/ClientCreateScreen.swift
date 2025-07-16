//
//  ClientCreateScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 29/05/2025.
//

import SwiftUI

struct ClientCreateScreen: View {
    
    @Environment(ClientStore.self) private var clientStore
    @Environment(Coordinator.self) private var coordinator
    @FocusState private var inFocus: InputFieldType?
    @State private var clientName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.interItem * 2) {
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { inFocus = .clientName })
        }
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
        Text(Translation.Client.clientNameLabel.val)
            .font(Font.title3(weight: .bold))
    }
    
    var clientNameTextView: some View {
        CustomTextField(inputFieldType: .clientName, inFocus: $inFocus, text: $clientName)
    }
    
    var addClientButton: some View {
        Button(action: didPressAddClient) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(clientName.isBlank)
    }
    
    func didPressAddClient() {
        clientStore.addClient(companyName: clientName) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                let success = GenericSuccessData(message: Translation.Client.addClientSuccessMessage.val)
                coordinator.push(.success(success))
            }
        }
    }
}

#Preview {
    ClientCreateScreen()
        .environment(ClientStore(requestManager: RequestManager.shared))
        .environment(Coordinator())
}
