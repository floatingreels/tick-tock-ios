//
//  GetProjectsRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct GetProjectsRequest: Requestable {
    
    var relativeURL: URL? { URL(string: "projects") }
    var method: RequestMethod { .get }
    var query: RequestQuery? = nil
    var body: RequestBody? = nil
}


