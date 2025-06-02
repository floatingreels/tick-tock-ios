//
//  DeleteSessionRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct DeleteSessionRequest: Requestable {
    
    let sessionId: Int
    var relativeURL: URL? { URL(string: "sessions/\(sessionId)") }
    var method: RequestMethod { .delete}
    var query: RequestQuery?
    var body: RequestBody?
}
