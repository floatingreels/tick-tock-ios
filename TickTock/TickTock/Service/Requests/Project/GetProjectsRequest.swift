//
//  GetProjectsRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct GetProjectsRequest: Requestable {
    
    let clientId: Int?
    
    var relativeURL: URL? {
        if let clientId {
            return URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects")
        } else {
            return URL(string: "users/\(TickTockDefaults.shared.userId)/projects")
        }
    }
    var method: RequestMethod { .get }
    var query: RequestQuery? = nil
    var body: RequestBody? = nil
}
