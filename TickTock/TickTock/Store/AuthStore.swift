//
//  AuthStore.swift
//  TickTock
//
//  Created by David Gunzburg on 19/06/2025.
//

import SwiftUI

@Observable
final class AuthStore {
    
    var isLoggedIn = BackendCredentials.shared.getAccessToken() != nil
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func signUp(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        completion: @escaping @Sendable (Result<LoginResponse, APIErrorResponse>) -> Void
    ) {
        requestManager.performUserRegistration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let auth):
                self.isLoggedIn = true
                BackendCredentials.shared.setAccessToken(auth.token)
                TickTockDefaults.shared.storeUser(user: auth.user)
            case .failure(_):
                self.isLoggedIn = false
            }
            completion(result)
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping @Sendable (Result<LoginResponse, APIErrorResponse>) -> Void) {
        requestManager.performUserLogin(
            email: email,
            password: password
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let auth):
                self.isLoggedIn = true
                BackendCredentials.shared.setAccessToken(auth.token)
                TickTockDefaults.shared.storeUser(user: auth.user)
            case .failure(_):
                self.isLoggedIn = false
            }
            completion(result)
        }
    }
    
    func logout() {
        isLoggedIn = false
        TickTockDefaults.shared.clearUserData()
        BackendCredentials.shared.clearTokens()
    }
}
