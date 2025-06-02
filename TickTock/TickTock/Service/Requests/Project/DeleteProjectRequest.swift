//
//  DeleteProjectRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct DeleteProjectRequest: Requestable {
    
    let projectId: Int
    var relativeURL: URL? { URL(string: "projects/\(projectId)") }
    var method: RequestMethod { .delete}
    var query: RequestQuery?
    var body: RequestBody?
}
