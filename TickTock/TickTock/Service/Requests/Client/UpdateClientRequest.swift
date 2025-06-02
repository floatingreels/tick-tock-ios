//
//  UpdateClientRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct UpdateClientRequest: Requestable {
    
    let clientId: Int
    let companyName: String?
    var relativeURL: URL? { URL(string: "clients/\(clientId)") }
    var method: RequestMethod { .put }
    var query: RequestQuery? = nil
    var body: RequestBody? {
        var body = [String: Any]()
        if let companyName {
            body["companyName"] = companyName
        }
        return body
    }
}
