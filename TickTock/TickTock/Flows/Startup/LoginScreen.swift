//
//  LoginView.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @FocusState private var inFocus: InputField?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isEmailValid: Bool? = nil
    @State private var isPasswordValid: Bool? = nil
    
    var body: some View {
        NavigationStack {
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
            }
        }
        .navigationTitle(Translation.Startup.loginNavTitle.val)
        
        .onAppear {
            print("LoginScreen appeared")
        }
        .onDisappear() {
            print("LoginScreen disappeared")
        }
    }
}

extension LoginScreen {
    
    var headerImage: some View {
        Image(systemName: "person.fill.badge.checkmark")
            .resizable()
            .frame(width: Size.detailHeaderLogo, height: Size.detailHeaderLogo)
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
    
    private func logIn() {
        RequestManager.shared.performUserLogin(
            email: email,
            password: password
        ) { response in
            switch response.result {
            case .success(_):
                print()
            case .failure(let error):
                print()
            }
        }
    }
    
    private func isFormValid() -> Bool { email.isValidEmail && password.isValidPassword }
}

#Preview {
    LoginScreen()
}
