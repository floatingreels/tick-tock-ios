//
//  AuthManager.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Combine
import Alamofire

final class AuthManager: ObservableObject {
    
    static let shared = AuthManager()
    private let service = BackendService()
    @Published var isLoggedIn = BackendCredentials.shared.getAccessToken() != nil

    private init() {}
    
    func performUserRegistration(firstName: String, lastName: String, email: String, password: String, completion: @escaping @Sendable (AFDataResponse<LoginResponse>) -> Void) {
        let request = UserRegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        service.execute(
            request: request,
            responseType: LoginResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let auth):
                    self.isLoggedIn = true
                    BackendCredentials.shared.setAccessToken(auth.token)
                    TickTockDefaults.shared.storeUser(user: auth.user)
                    completion(response)
                case .failure(_):
                    self.isLoggedIn = false
                    completion(response)
                }
            }
    }
    
    func performUserLogin(email: String, password: String, completion: @escaping @Sendable (AFDataResponse<LoginResponse>) -> Void) {
        let request = UserLoginRequest(email: email, password: password)
        service.execute(
            request: request,
            responseType: LoginResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let auth):
                    self.isLoggedIn = true
                    BackendCredentials.shared.setAccessToken(auth.token)
                    TickTockDefaults.shared.storeUser(user: auth.user)
                    completion(response)
                case .failure(_):
                    self.isLoggedIn = false
                    completion(response)
                }
            }
    }
    
    func logout() {
        isLoggedIn = false
        TickTockDefaults.shared.clearUserData()
        BackendCredentials.shared.clearTokens()
    }
}
