//
//  ProjectDetailRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct ProjectDetailRequest: Requestable {
    let projectId: Int
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/projects/\(projectId)") }
    var method: RequestMethod { .get}
    var query: RequestQuery?
    var body: RequestBody?
}
