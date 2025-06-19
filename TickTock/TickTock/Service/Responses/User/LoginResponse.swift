//
//  LoginResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 23/05/2025.
//

struct LoginResponse: Respondable, Codable {
    let success: Bool
    let message: String?
    let user: User
    let token: String
}

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case firstName = "firstName"
        case lastName = "lastName"
        case email
    }
}
