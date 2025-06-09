//
//  DeleteProjectRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct DeleteProjectRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)") }
    var method: RequestMethod { .delete}
    var query: RequestQuery?
    var body: RequestBody?
}
