//
//  LoginView.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(AuthStore.self) private var authStore
    @Environment(Coordinator.self) private var coordinator
    @FocusState private var inFocus: InputFieldType?
    @State private var email: String = ""
    @State private var password: String = ""
    private let fieldSequence: [InputFieldType] = [.email, .password]
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
            emailTextField
            passwordTextField
            logInButton
            Spacer()
        }
        .navigationTitle(Translation.Startup.loginNavTitle.val)
        .padding(Spacing.interItem)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { inFocus = .email })
        }
    }
}

private extension LoginScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.circle", true))
    }
    
    var headerText: some View {
        Text(Translation.Startup.loginFormDescription.val)
    }
    
    var emailTextField: some View {
        CustomTextField(inputFieldType: .email, inFocus: $inFocus, text: $email, fieldSequence: fieldSequence)
    }
    
    var passwordTextField: some View {
        CustomTextField(inputFieldType: .password, inFocus: $inFocus, text: $password, fieldSequence: fieldSequence)
    }
    
    var logInButton: some View {
        Button(action: logIn) {
            Text(Translation.General.buttonNext.val)
                .textContentType(.givenName)
        }
        .accentColor(.labelLinks)
        .disabled(!isFormValid())
    }
    
    func logIn() {
        authStore.logIn(email: email, password: password) { [coordinator] result in
            switch result {
            case .success:
                coordinator.push(.home)
            case .failure(let error):
                coordinator.presentAlert(CustomAlert.serviceError(error))
            }
        }
    }
    
    func isFormValid() -> Bool { email.isValidEmail && password.isValidPassword }
}

#Preview {
    LoginScreen()
}
