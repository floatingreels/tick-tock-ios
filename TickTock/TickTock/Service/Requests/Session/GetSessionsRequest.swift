//
//  GetSessionsRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct GetSessionsRequest: Requestable {
    
    var relativeURL: URL? { URL(string: "sessions") }
    var method: RequestMethod { .get }
    var query: RequestQuery? = nil
    var body: RequestBody? = nil
}
