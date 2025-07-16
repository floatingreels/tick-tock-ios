//
//  RegisterScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct RegisterScreen: View {
    
    @Environment(AuthStore.self) private var authStore
    @Environment(Coordinator.self) private var coordinator
    @FocusState private var inFocus: InputFieldType?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    private let fieldSequence: [InputFieldType] = [.firstName, .lastName,.email, .password, .passwordConfirm]
    
    var body: some View {
        
            VStack(spacing: Spacing.interItem * 2) {
                headerImage
                headerText
                VStack(spacing: Spacing.interItem) {
                    firstNameTextField
                    lastNameTextField
                    emailTextField
                    passwordTextField
                    passwordConfirmTextField
                }
                signupButton
                Spacer()
            }
            .navigationTitle(Translation.Startup.registerNavTitle.val)
            .padding(Spacing.interItem)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { inFocus = .firstName })
            }
    }
}



private extension RegisterScreen {
    
    var headerImage: some View {
        HeaderImageView(image: ("person.crop.circle.badge.plus", true))
    }
    
    var headerText: some View {
        Text(Translation.Startup.registerFormDescription.val)
    }
    
    var firstNameTextField: some View {
        CustomTextField(inputFieldType: .firstName, inFocus: $inFocus, text: $firstName, fieldSequence: fieldSequence)
    }
    
    var lastNameTextField: some View {
        CustomTextField(inputFieldType: .lastName, inFocus: $inFocus, text: $lastName, fieldSequence: fieldSequence)
    }
    
    var emailTextField: some View {
        CustomTextField(inputFieldType: .email, inFocus: $inFocus, text: $email, fieldSequence: fieldSequence)
    }
    
    var passwordTextField: some View {
        CustomTextField(inputFieldType: .password, inFocus: $inFocus, text: $password, fieldSequence: fieldSequence)
    }
    
    var passwordConfirmTextField: some View {
        CustomTextField(inputFieldType: .passwordConfirm, inFocus: $inFocus, text: $passwordConfirm, validation: $password, fieldSequence: fieldSequence)
    }
    
    var signupButton: some View {
        Button(action: signUp) {
            Text(Translation.General.buttonNext.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isFormValid())
    }
    
    func signUp() {
     authStore.signUp(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        ) { [coordinator] data in
            switch data.result {
            case .success(_):
                coordinator.push(.home)
            case .failure(let error):
                coordinator.presentAlert(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func isFormValid() -> Bool {
        return
            !firstName.isBlank &&
            !lastName.isBlank &&
            email.isValidEmail &&
            password.isValidPassword &&
            password == passwordConfirm
    }
}

#Preview {
    RegisterScreen()
}
