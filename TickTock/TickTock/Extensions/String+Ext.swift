//
//  String+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 21/05/2025.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return self.count >= 4
        
        /* actual validation to be implemented in later stage
        let passRegEx = "^((?=.*[A-Z])(?=.*\\d).{8,})|((?=.*[a-z])(?=.*\\d).{8,})|((?=.*\\d)(?=.*[@$!%*#?&]).{8,})|((?=.*[a-z])(?=.*[A-Z]).{8,})|(^(?=.*[A-Z])(?=.*[@$!%*#?&]).{8,})|((?=.*[a-z])(?=.*[@$!%*#?&]).{8,})$"
        let passTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: self) */
    }
    
    var isBlank: Bool {
        return self.trimmed().isEmpty
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
