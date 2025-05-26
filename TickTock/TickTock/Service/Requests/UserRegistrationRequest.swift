//
//  UserRegistrationRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 21/05/2025.
//

import Foundation

struct UserRegistrationRequest: Requestable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    var relativeURL: URL? { URL(string: "users/register") }
    
    var method: RequestMethod { .post }
    
    var query: RequestQuery? { nil }
    
    var body: RequestBody? {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
    }
}
