//
//  SessionDetailRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct SessionDetailRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    let sessionId: Int
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)/sessions/\(sessionId)") }
    var method: RequestMethod { .get}
    var query: RequestQuery?
    var body: RequestBody?
}
