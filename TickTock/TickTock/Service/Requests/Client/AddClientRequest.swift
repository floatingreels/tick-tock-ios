//
//  AddClientRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 30/05/2025.
//

import Foundation

struct AddClientRequest: Requestable {
    
    let companyName: String
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        return [
            "companyName": companyName
        ]
    }
}
