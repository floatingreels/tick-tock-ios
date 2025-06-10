//
//  LoginView.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var alertinator: Alertinator
    @EnvironmentObject private var coordinator: Coordinator
    
    @FocusState private var inFocus: InputField?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isEmailValid: Bool? = nil
    @State private var isPasswordValid: Bool? = nil
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
            VStack(spacing: Spacing.interItem / 2) {
                emailTextView
                if let isEmailValid {
                    if !isEmailValid {
                        emailErrorText
                    }
                }
            }
            VStack(spacing: Spacing.interItem / 2) {
                passwordSecureField
                if let isPasswordValid {
                    if !isPasswordValid {
                        passwordErrorText
                    }
                }
            }
            logInButton
            Spacer()
        }
        .navigationTitle(Translation.Startup.loginNavTitle.val)
        .textFieldStyle(.roundedBorder)
        .padding(Spacing.interItem)
    }
}

private extension LoginScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.circle", true))
    }
    
    var headerText: some View {
        Text(Translation.Startup.loginFormDescription.val)
    }
    
    var emailTextView: some View {
        TextField(
            Translation.General.labelEmail.val,
            text: $email,
            onEditingChanged: { isEdting in
                isEmailValid = isEdting ? nil : email.isValidEmail
            },
            onCommit: {
                isEmailValid = email.isValidEmail
                inFocus = .password
            }
        )
        .textInputAutocapitalization(.never)
        .textContentType(.emailAddress)
        .keyboardType(.emailAddress)
        .submitLabel(.next)
        .focused($inFocus, equals: .email)
    }
    
    var emailErrorText: some View {
        Text(Translation.General.emailValidation.val)
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
    }
    
    var passwordSecureField: some View {
        SecureField(
            Translation.General.labelPassword.val,
            text: $password,
            onCommit: {
                isPasswordValid = password.isValidPassword
                inFocus = .passwordConfirm
            }
        )
        .textContentType(.none)
        .disableAutocorrection(true)
        .submitLabel(.next)
        .focused($inFocus, equals: .password)
    }
    
    var passwordErrorText: some View {
        Text(Translation.General.passwordRequirements.val)
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
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
        AuthManager.shared.performUserLogin(
            email: email,
            password: password
        ) { [alertinator, coordinator] data in
            switch data.result {
            case .success:
                coordinator.push(.home)
            case .failure(let error):
                alertinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    private func isFormValid() -> Bool { email.isValidEmail && password.isValidPassword }
}

#Preview {
    LoginScreen()
}
