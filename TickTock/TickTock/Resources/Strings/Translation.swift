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
        case labelEmail = "general_label_email"
        case labelPassword = "general_label_password"
        case labelPasswordConfirm = "general_label_password_confirm"
        case labelFirstName = "general_label_name_first"
        case labelLastName = "general_label_name_last"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Startup: String.LocalizationValue {
        case loginNavTitle = "login_navigation_title"
        case registerNavTitle = "register_navigation_title"
        case buttonLogin = "welcome_button_login"
        case buttonRegister = "welcome_button_register"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
}
