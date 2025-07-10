//
//  PasswordTextField.swift
//  TickTock
//
//  Created by David Gunzburg on 09/07/2025.
//

import SwiftUI

enum InputFieldType {
    
    case firstName
    case lastName
    case email
    case password
    case passwordConfirm
    
    var label: String {
        switch self {
        case .firstName: Translation.General.labelFirstName.val
        case .lastName: Translation.General.labelLastName.val
        case .email: Translation.General.labelEmail.val
        case .password: Translation.General.labelPassword.val
        case .passwordConfirm: Translation.General.labelPasswordConfirm.val
        }
    }
    
    var errorText: String? {
        switch self {
        case .firstName: return Translation.General.firstNameValidation.val
        case .lastName: return Translation.General.lastNameValidation.val
        case .email: return Translation.General.emailValidation.val
        case .password: return Translation.General.passwordRequirements.val
        case .passwordConfirm: return Translation.General.passwordMismatch.val
        }
    }
    
    var autoCapitalization: TextInputAutocapitalization {
        switch self {
        case .firstName, .lastName: return .words
        case .email, .password, .passwordConfirm: return .never
        }
    }
     
    var disableAutocorrection: Bool {
        switch self {
        case .firstName, .lastName, .email, .password, .passwordConfirm: return true
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .firstName: return .givenName
        case .lastName: return .familyName
        case .email: return .emailAddress
        case .password: return .newPassword
        case .passwordConfirm: return .password
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .firstName, .lastName: return .default
        case .email: return .emailAddress
        case .password, .passwordConfirm: return .default
        }
    }
    
    func isInputValid(_ input: String, comparison: String? = nil) -> Bool {
        switch self {
        case .firstName, .lastName: return input.isBlank == false
        case .email: return input.isValidEmail
        case .password: return input.isValidPassword
        case .passwordConfirm: return input == comparison
        }
    }
}


struct CustomTextField: View {
    
    let inputFieldType: InputFieldType
    @FocusState.Binding var inFocus: InputFieldType?
    @Binding var text: String
    @Binding var validation: String
    var relinquishFocus: InputFieldType? = nil
    @State private var isValid: Bool? = nil
    
    init(
        inputFieldType: InputFieldType,
        inFocus: FocusState<InputFieldType?>.Binding,
        text: Binding<String>,
        validation: Binding<String>,
        relinquishFocus: InputFieldType? = nil
    ) {
        self.inputFieldType = inputFieldType
        self._inFocus = inFocus
        self._text = text
        self._validation = validation
        self.relinquishFocus = relinquishFocus
    }
    
    init(
        inputFieldType: InputFieldType,
        inFocus: FocusState<InputFieldType?>.Binding,
        text: Binding<String>,
        relinquishFocus: InputFieldType? = nil
    ) {
        self.inputFieldType = inputFieldType
        self._inFocus = inFocus
        self._text = text
        self._validation = .constant("")
        self.relinquishFocus = relinquishFocus
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem / 2) {
            switch inputFieldType {
            case .password, .passwordConfirm:
                secureField
            default:
                textField
            }
            if let isValid {
                if !isValid {
                    errorLabel
                }
            }
        }
    }
}

private extension CustomTextField {
    
    var textField: some View {
        TextField(
            inputFieldType.label,
            text: $text,
            onEditingChanged: { isEdting in
                isValid = isEdting ? nil : inputFieldType.isInputValid(text)
            },
            onCommit: {
                isValid = inputFieldType.isInputValid(text)
                inFocus = relinquishFocus
            }
        )
        .foregroundStyle(Color.labelSecondary)
        .autocorrectionDisabled(inputFieldType.disableAutocorrection)
        .textInputAutocapitalization(inputFieldType.autoCapitalization)
        .textContentType(inputFieldType.textContentType)
        .keyboardType(inputFieldType.keyboardType)
        .submitLabel(relinquishFocus != nil ? .next : .done)
        .focused($inFocus, equals: inputFieldType)
    }
    
    var secureField: some View {
        SecureField(
            Translation.General.labelPassword.val,
            text: $text,
            onCommit: {
                isValid = inputFieldType.isInputValid(text, comparison: validation.isBlank ? nil : validation)
                inFocus = relinquishFocus
            }
        )
        .autocorrectionDisabled(inputFieldType.disableAutocorrection)
        .textInputAutocapitalization(inputFieldType.autoCapitalization)
        .textContentType(inputFieldType.textContentType)
        .keyboardType(inputFieldType.keyboardType)
        .submitLabel(relinquishFocus != nil ? .next : .done)
        .focused($inFocus, equals: inputFieldType)
    }
    
    var errorLabel: some View {
        Text(inputFieldType.errorText ?? "")
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
    }
}

#Preview {
    @Previewable @State var text: String = "email_address@domain.com"
    @FocusState var inFocus: InputFieldType?
    CustomTextField(inputFieldType: .email, inFocus: $inFocus, text: $text)
}
