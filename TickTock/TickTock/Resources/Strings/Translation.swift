//
//  Translation.swift
//  TickTock
//
//  Created by David Gunzburg on 21/05/2025.
//

import SwiftUICore
import Foundation

enum Translation {}

extension Translation {
    
    enum Error: String.LocalizationValue {
        case general_title = "error_general_title"
        case general_message = "error_general_message"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
        
    enum General: String.LocalizationValue {
        case buttonCancel = "general_button_cancel"
        case buttonClose = "general_button_close"
        case buttonCreate = "general_button_create"
        case buttonNext = "general_button_next"
        case buttonDone = "general_button_done"
        case buttonOk = "general_button_ok"
        case firstNameValidation = "general_first_name_validation_message"
        case lastNameValidation = "general_last_name_validation_message"
        case emailValidation = "general_email_validation_message"
        case labelEmail = "general_label_email"
        case labelFirstName = "general_label_name_first"
        case labelLastName = "general_label_name_last"
        case labelPassword = "general_label_password"
        case labelPasswordConfirm = "general_label_password_confirm"
        case passwordMismatch = "general_password_mismatch"
        case passwordRequirements = "general_password_requirements_message"
        case successScreenMessage = "general_success_message"
        case successNavTitle = "general_success_navigation_title"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Startup: String.LocalizationValue {
        case buttonAddClient = "home_button_add_client"
        case buttonListClients = "home_button_list_clients"
        case buttonListProjects = "home_button_list_projects"
        case buttonLogin = "welcome_button_login"
        case buttonNewProject = "home_button_new_project"
        case buttonRegister = "welcome_button_register"
        case buttonStartSession = "home_button_start_session"
        case homeNavTitle = "home_navigation_title"
        case loginFormDescription = "login_form_description"
        case loginNavTitle = "login_navigation_title"
        case registerFormDescription = "register_form_description"
        case registerNavTitle = "register_navigation_title"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Client: String.LocalizationValue {
        case addClientNavTitle = "add_client_navigation_title"
        case addClientSuccessMessage = "add_client_success_message"
        case addClientFormDescription = "add_client_form_description"
        case clientNameLabel = "client_label_name"
        case clientNameValidation = "client_name_validation_message"
        case detailClientNewProject = "detail_client_button_new_project"
        case listClientsNavTitle = "list_clients_navigation_title"
        case detailClientNavTitle = "detail_client_navigation_title"
        case detailClientProjectsLabel = "detail_client_projects_label"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Project: String.LocalizationValue {
        case addProjectNavTitle = "add_project_navigation_title"
        case addProjectSuccessMessage = "add_project_success_message"
        case addProjectFormDescription = "add_project_form_description"
        case addProjectClientLabel = "add_project_client_label"
        case addProjectNewClientButton = "add_project_new_client_button"
        case projectNameLabel = "project_label_name"
        case projectNameValidation = "project_name_validation_message"
        case listProjectsNavTitle = "list_project_navigation_title"
        case detailProjectNavTitle = "detail_project_navigation_title"
        case detailProjectSessionsLabel = "detail_project_sessions_label"
        case projectRateLabel = "project_label_rate"        
        case projectRateValidation = "project_rate_validation_message"
        case projectRateTypeHour = "project_rate_type_hour"
        case projectRateTypeDay = "project_rate_type_day"
        case projectRateTypeWeek = "project_rate_type_week"
        case projectRateTypeMonth = "project_rate_type_month"
        case detailProjectStartSession = "project_start_session_button"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
    
    enum Session: String.LocalizationValue {
        case activeSessionNavTitle = "active_session_navigation_title"
        case activeSessionStartButton = "active_session_start_button"
        case activeSessionStopButton = "active_session_stop_button"
        
        var val: String {
            let res = LocalizedStringResource(self.rawValue, table: "Localizable")
            return String(localized: res)
        }
    }
}
