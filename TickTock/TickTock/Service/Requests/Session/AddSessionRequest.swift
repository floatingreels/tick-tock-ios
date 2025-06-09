//
//  AddSessionRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct AddSessionRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    let start: Date?
    let end: Date?
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)/sessions") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        var body: [String: Any] = [:]
        if let start {
            body["startedAt"] = ISODateFormatter.shared.isoStringFromDate(start)
        }
        if let end {
            body["endedAt"] = ISODateFormatter.shared.isoStringFromDate(end)
        }
        return body
    }
}
