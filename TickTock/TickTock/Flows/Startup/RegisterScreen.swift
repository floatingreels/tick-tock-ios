//
//  RegisterScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

enum InputField {
        case firstName, lastName, email, password, passwordConfirm
}

struct RegisterScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var isEmailValid: Bool? = nil
    @State private var isPasswordValid: Bool? = nil
    @State private var doPasswordsMatch: Bool? = nil
    @FocusState private var inFocus: InputField?
    
    var body: some View {
        
            VStack(spacing: Spacing.interItem * 2) {
                headerImage
                headerText
                VStack(spacing: Spacing.interItem) {
                    firstNameTextView
                    lastNameTextView
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
                    VStack(spacing: Spacing.interItem / 2) {
                        passwordConfirmSecureField
                        if let doPasswordsMatch {
                            if !doPasswordsMatch {
                                passwordConfirmErrorText
                            }
                        }
                    }
                }
                signupButton
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
            .navigationTitle(Translation.Startup.registerNavTitle.val)
    }
}



private extension RegisterScreen {
    
    var headerImage: some View {
        Image(systemName: "person.crop.circle.badge.plus")
            .resizable()
            .frame(width: Size.detailHeaderLogo, height: Size.detailHeaderLogo)
    }
    
    var headerText: some View {
        Text(Translation.Startup.registerFormDescription.val)
    }
    
    var firstNameTextView: some View {
        TextField(
            Translation.General.labelFirstName.val,
            text: $firstName,
            onCommit: {
                inFocus = .lastName
            })
        .textContentType(.givenName)
        .keyboardType(.default)
        .submitLabel(.next)
        .focused($inFocus, equals: .firstName)
    }
    
    var lastNameTextView: some View {
        TextField(
            Translation.General.labelLastName.val,
            text: $lastName,
            onCommit: {
                inFocus = .email
            })
        .textContentType(.familyName)
        .keyboardType(.default)
        .submitLabel(.next)
        .focused($inFocus, equals: .lastName)
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
        .textContentType(.newPassword)
        .disableAutocorrection(true)
        .submitLabel(.next)
        .focused($inFocus, equals: .password)
    }
    
    var passwordErrorText: some View {
        Text(Translation.General.passwordRequirements.val)
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
    }
    
    var passwordConfirmSecureField: some View {
        SecureField(
            Translation.General.labelPasswordConfirm.val,
            text: $passwordConfirm,
            onCommit: {
                let didEnterPasswords = !password.isBlank && !passwordConfirm.isBlank
                doPasswordsMatch = didEnterPasswords && password == passwordConfirm
            }
        )
        .textContentType(.password)
        .disableAutocorrection(true)
        .submitLabel(.done)
        .focused($inFocus, equals: .passwordConfirm)
    }
    
    var passwordConfirmErrorText: some View {
        Text(Translation.General.passwordMismatch.val)
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
    }
    
    var signupButton: some View {
        Button(action: signUp) {
            Text(Translation.General.buttonNext.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isFormValid())
    }
    
    func signUp() {
        AuthManager.shared.performUserRegistration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        ) { [coordinator] response in
            switch response.result {
            case .success(_):
                coordinator.push(.login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func isFormValid() -> Bool {
        return
            !firstName.isBlank &&
            !lastName.isBlank &&
            email.isValidEmail &&
            password.isValidPassword &&
            doPasswordsMatch ?? false
    }
}

#Preview {
    RegisterScreen()
}
