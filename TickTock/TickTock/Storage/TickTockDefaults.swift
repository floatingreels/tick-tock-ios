//
//  TickTockDefaults.swift
//  TickTock
//
//  Created by David Gunzburg on 28/05/2025.
//

import Foundation

final class TickTockDefaults {
    
    static let shared = TickTockDefaults()
    private let defaults = UserDefaults.standard
    
    private let userIdKey = "userIdKey"
    private let userEmailKey = "userEmailKey"
    private let userFirstNameKey = "userFirstNameKey"
    private let userLastNameKey = "userLastNameKey"
    
    private init() {}
    
    var userId: Int? { defaults.integer(forKey: userIdKey) }
    
    var firstName: String? {
        guard let firstName = defaults.string(forKey: userFirstNameKey),
              !firstName.isBlank
        else { return nil }
        return firstName
    }
    
    var lastName: String? {
        guard let lastName = defaults.string(forKey: userLastNameKey),
              !lastName.isBlank
        else { return nil }
        return lastName
    }
    
    var email: String? {
        guard let email = defaults.string(forKey: userEmailKey),
              !email.isBlank
        else { return nil }
        return email
    }
    
    func storeUser(user: User) {
        defaults.set(user.id, forKey: userIdKey)
        defaults.set(user.firstName, forKey: userFirstNameKey)
        defaults.set(user.lastName, forKey: userLastNameKey)
        defaults.set(user.email, forKey: userEmailKey)
    }
    
    func clearUserData() {
        defaults.removeObject(forKey: userIdKey)
        defaults.removeObject(forKey: userFirstNameKey)
        defaults.removeObject(forKey: userLastNameKey)
        defaults.removeObject(forKey: userEmailKey)
    }
}

