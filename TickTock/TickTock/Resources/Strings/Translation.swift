//
//  Translation.swift
//  TickTock
//
//  Created by David Gunzburg on 21/05/2025.
//

import SwiftUICore
import Foundation

enum Translation {
    
}

extension Translation {
        
    enum General: String.LocalizationValue {
        case buttonNext = "general_button_next"
        case labelEmail = "general_label_email"
        case labelPassword = "general_label_password"
        case labelPasswordConfirm = "general_label_password_confirm"
        case labelFirstName = "general_label_name_first"
        case labelLastName = "general_label_name_last"
        case passwordRequirements = "general_password_requirements_message"
        case emailValidation = "general_email_validation_message"
        case passwordMismatch = "general_password_mismatch"
        
        var val: String {
            
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Startup: String.LocalizationValue {
        case homeNavTitle = "home_navigation_title"
        case loginNavTitle = "login_navigation_title"
        case registerNavTitle = "register_navigation_title"
        case buttonLogin = "welcome_button_login"
        case buttonRegister = "welcome_button_register"
        case buttonAddClient = "home_button_add_client"
        case buttonNewProject = "home_button_new_project"
        case buttonStartSession = "home_button_start_session"
        case registerFormDescription = "register_form_description"
        case loginFormDescription = "login_form_description"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Client: String.LocalizationValue {
        case addClientNavTitle = "add_client_navigation_title"
        case clientNameLabel = "client_name_label"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
}
