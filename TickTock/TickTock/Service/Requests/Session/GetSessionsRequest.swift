//
//  GetSessionsRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct GetSessionsRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)/sessions") }
    var method: RequestMethod { .get }
    var query: RequestQuery? = nil
    var body: RequestBody? = nil
}
