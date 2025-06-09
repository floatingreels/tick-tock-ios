//
//  DeleteClientRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct DeleteClientRequest: Requestable {
    
    let clientId: Int
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)") }
    var method: RequestMethod { .delete }
    var query: RequestQuery? = nil
    var body: RequestBody? = nil
}
