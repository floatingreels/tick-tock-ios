//
//  AddClientRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 30/05/2025.
//

import Foundation

struct AddClientRequest: Requestable {
    
    let companyName: String
    var relativeURL: URL? { URL(string: "clients") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        let body: [String: Any] = [
            "companyName": companyName,
            "userId": TickTockDefaults.shared.userId
        ]
        return body
    }
}
