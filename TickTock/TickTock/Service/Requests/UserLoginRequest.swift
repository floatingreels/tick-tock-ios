//
//  UserLoginRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 24/05/2025.
//

import Foundation

struct UserLoginRequest: Requestable {
    let email: String
    let password: String
    
    var relativeURL: URL? { URL(string: "users/login") }
    
    var method: RequestMethod { .post }
    
    var query: RequestQuery? { nil }
    
    var body: RequestBody? {
        return [
            "email": email,
            "password": password
        ]
    }
}
