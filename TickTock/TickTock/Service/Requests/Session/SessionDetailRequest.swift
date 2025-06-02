//
//  SessionDetailRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct SessionDetailRequest: Requestable {
    
    let sessionId: Int
    var relativeURL: URL? { URL(string: "sessions/\(sessionId)") }
    var method: RequestMethod { .get}
    var query: RequestQuery?
    var body: RequestBody?
}
