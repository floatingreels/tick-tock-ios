//
//  UpdateSessionRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct UpdateSessionRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    let sessionId: Int
    let start: Date?
    let end: Date?
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)/sessions/\(sessionId)") }
    var method: RequestMethod { .put }
    var query: RequestQuery? = nil
    var body: RequestBody? {
        var body = [String: Any]()
        if let start {
            body["startedAt"] = start
        }
        if let end {
            body["endedAt"] = end
        }
        return body
    }
}
