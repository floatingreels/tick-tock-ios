//
//  AddSessionRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct AddSessionRequest: Requestable {
    
    let projectId: String
    let start: Date?
    let end: Date?
    var relativeURL: URL? { URL(string: "sessions") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        var body = ["projectId": projectId]
        if let start {
            body["startedAt"] = ISODateFormatter.shared.isoStringFromDate(start)
        }
        if let end {
            body["endedAt"] = ISODateFormatter.shared.isoStringFromDate(end)
        }
        return body
    }
}
