//
//  CustomTextField.swift
//  TickTock
//
//  Created by David Gunzburg on 09/07/2025.
//

import SwiftUI

enum InputFieldType {
    
    case firstName
    case lastName
    case clientName
    case projectName
    case email
    case password
    case passwordConfirm
    case rate
    
    var label: String {
        switch self {
        case .firstName: Translation.General.labelFirstName.val
        case .lastName: Translation.General.labelLastName.val
        case .clientName: Translation.Client.clientNameLabel.val
        case .projectName: Translation.Project.projectNameLabel.val
        case .email: Translation.General.labelEmail.val
        case .password: Translation.General.labelPassword.val
        case .passwordConfirm: Translation.General.labelPasswordConfirm.val
        case .rate: Translation.Project.projectRateLabel.val
        }
    }
    
    var errorText: String? {
        switch self {
        case .firstName: Translation.General.firstNameValidation.val
        case .lastName: Translation.General.lastNameValidation.val
        case .clientName: Translation.Client.clientNameValidation.val
        case .projectName: Translation.Project.projectNameValidation.val
        case .email: Translation.General.emailValidation.val
        case .password: Translation.General.passwordRequirements.val
        case .passwordConfirm: Translation.General.passwordMismatch.val
        case .rate: Translation.Project.projectRateValidation.val
        }
    }
    
    var autoCapitalization: TextInputAutocapitalization {
        switch self {
        case .firstName, .lastName, .clientName: .words
        case .projectName: .sentences
        case .email, .password, .passwordConfirm, .rate: .never
        }
    }
    
    var disableAutocorrection: Bool {
        switch self {
        case .firstName, .lastName, .clientName, .projectName: false
        case .email, .password, .passwordConfirm, .rate: true
        }
    }
    
    var textContentType: UITextContentType? {
        switch self {
        case .firstName: .givenName
        case .lastName: .familyName
        case .clientName: .organizationName
        case .projectName: .name
        case .email: .emailAddress
        case .password: .newPassword
        case .passwordConfirm: .password
        case .rate: nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .firstName, .lastName, .clientName, .projectName: .default
        case .email: .emailAddress
        case .password, .passwordConfirm: .default
        case .rate: .decimalPad
        }
    }
    
    func isInputValid(_ input: String, comparison: String? = nil) -> Bool {
        switch self {
        case .firstName, .lastName, .clientName, .projectName: input.isBlank == false
        case .email: input.isValidEmail
        case .password: input.isValidPassword
        case .passwordConfirm: input == comparison
        case .rate: input.isValidRate
        }
    }
}

struct CustomTextField: View {
    
    let inputFieldType: InputFieldType
    @FocusState.Binding var inFocus: InputFieldType?
    @Binding var text: String
    @Binding var value: Double
    @Binding var validation: String
    @State private var isValid: Bool? = nil
    private let fieldSequence: [InputFieldType]
    
    init(
        inputFieldType: InputFieldType,
        inFocus: FocusState<InputFieldType?>.Binding,
        value: Binding<Double>,
        fieldSequence: [InputFieldType] = []
    ) {
        self.inputFieldType = inputFieldType
        self._inFocus = inFocus
        self._text = .constant("")
        self._value = value
        self._validation = .constant("")
        self.fieldSequence = fieldSequence
    }
    
    init(
        inputFieldType: InputFieldType,
        inFocus: FocusState<InputFieldType?>.Binding,
        text: Binding<String>,
        validation: Binding<String>,
        fieldSequence: [InputFieldType] = []
    ) {
        self.inputFieldType = inputFieldType
        self._inFocus = inFocus
        self._text = text
        self._value = .constant(0.0)
        self._validation = validation
        self.fieldSequence = fieldSequence
    }
    
    init(
        inputFieldType: InputFieldType,
        inFocus: FocusState<InputFieldType?>.Binding,
        text: Binding<String>,
        fieldSequence: [InputFieldType] = []
    ) {
        self.inputFieldType = inputFieldType
        self._inFocus = inFocus
        self._text = text
        self._value = .constant(0.0)
        self._validation = .constant("")
        self.fieldSequence = fieldSequence
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem / 2) {
            switch inputFieldType {
            case .password, .passwordConfirm: secureField
            case .rate: currencyField
            default: textField
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
            onCommit: handleSubmit
        )
        .foregroundStyle(Color.labelSecondary)
        .autocorrectionDisabled(inputFieldType.disableAutocorrection)
        .textInputAutocapitalization(inputFieldType.autoCapitalization)
        .textContentType(inputFieldType.textContentType)
        .keyboardType(inputFieldType.keyboardType)
        .submitLabel(isLastField ? .done : .next)
        .focused($inFocus, equals: inputFieldType)
        .toolbar {
            if inFocus == inputFieldType {
                ToolbarItemGroup(placement: .keyboard) {
                    keyboardToolbar
                }
            }
        }
    }
    
    var secureField: some View {
        SecureField(
            inputFieldType.label,
            text: $text,
            onCommit: handleSubmit
        )
        .textInputAutocapitalization(inputFieldType.autoCapitalization)
        .textContentType(inputFieldType.textContentType)
        .keyboardType(inputFieldType.keyboardType)
        .submitLabel(isLastField ? .done : .next)
        .focused($inFocus, equals: inputFieldType)
        .toolbar {
            if inFocus == inputFieldType {
                ToolbarItemGroup(placement: .keyboard) {
                    keyboardToolbar
                }
            }
        }
    }
    
    var currencyField: some View {
        TextField(
            inputFieldType.label,
            value: $value,
            format: .currency(code: "EUR")
        )
        .onSubmit(handleSubmit)
        .keyboardType(inputFieldType.keyboardType)
        .submitLabel(isLastField ? .done : .next)
        .focused($inFocus, equals: inputFieldType)
        .toolbar {
            if inFocus == inputFieldType {
                ToolbarItemGroup(placement: .keyboard) {
                    keyboardToolbar
                }
            }
        }
    }
    
    var nextField: InputFieldType? {
        guard let currentIndex = fieldSequence.firstIndex(of: inputFieldType),
              currentIndex < fieldSequence.count - 1 else {
            return nil
        }
        return fieldSequence[currentIndex + 1]
    }
    
    var isLastField: Bool {
        nextField == nil
    }
    
    var errorLabel: some View {
        Text(inputFieldType.errorText ?? "")
            .font(Font.caption2())
            .foregroundStyle(Color.labelDestructive)
    }
    
    var keyboardToolbar: some View {
        let label = isLastField ? Translation.General.buttonDone.val : Translation.General.buttonNext.val
        return HStack {
            Spacer()
            Button(label, action: handleSubmit)
                .font(.body(weight: .bold))
                .foregroundStyle(Color.buttonLinks)
        }
    }
    
    func handleSubmit() {
        switch inputFieldType {
        case .passwordConfirm:
            isValid = inputFieldType.isInputValid(text, comparison: validation.isBlank ? nil : validation)
        case .rate:
            isValid = inputFieldType.isInputValid("\(value)")
        default:
            isValid = inputFieldType.isInputValid(text)
        }
        inFocus = nextField
    }
}

#Preview {
    @Previewable @State var text: String = "email_address@domain.com"
    @FocusState var inFocus: InputFieldType?
    CustomTextField(inputFieldType: .email, inFocus: $inFocus, text: $text)
}
