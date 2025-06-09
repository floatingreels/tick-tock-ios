//
//  RegistrationResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import Foundation

struct RegistrationResponse: Codable {
    let user: User
    let token: String
}
