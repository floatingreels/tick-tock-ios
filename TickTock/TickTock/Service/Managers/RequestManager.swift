//
//  RequestManager.swift
//  TickTock
//
//  Created by David Gunzburg on 22/05/2025.
//

import Foundation
import Alamofire

final class RequestManager {
    
    static let shared = RequestManager()
    private let service = BackendService()
    
    func performUserRegistration(firstName: String, lastName: String, email: String, password: String, completion: @escaping @Sendable (AFDataResponse<Empty>) -> Void) {
        let request = UserRegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        service.execute(
            request: request,
            responseType: Empty.self,
            completion: completion
        )
    }
    
    func performUserLogin(email: String, password: String, completion: @escaping @Sendable (AFDataResponse<Empty>) -> Void) {
        let request = UserLoginRequest(email: email, password: password)
        service.execute(
            request: request,
            responseType: Empty.self,
            completion: completion
        )
    }
}
