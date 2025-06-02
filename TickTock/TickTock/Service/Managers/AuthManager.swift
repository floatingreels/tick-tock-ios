//
//  AuthManager.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation
import Alamofire

final class AuthManager {
    
    static let shared = AuthManager()
    private let service = BackendService()
    
    func performUserRegistration(firstName: String, lastName: String, email: String, password: String, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = UserRegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        service.execute(request: request, completion: completion)
    }
    
    func performUserLogin(email: String, password: String, completion: @escaping @Sendable (AFDataResponse<LoginResponse>) -> Void) {
        let request = UserLoginRequest(email: email, password: password)
        service.execute(
            request: request,
            responseType: LoginResponse.self) { response in
                switch response.result {
                case .success(let login):
                    BackendCredentials.shared.setAccessToken(login.token)
                    TickTockDefaults.shared.storeUser(user: login.user)
                    completion(response)
                case .failure(_):
                    completion(response)
                }
            }
    }
}
