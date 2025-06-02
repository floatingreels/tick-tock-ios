//
//  AddProjectRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct AddProjectRequest: Requestable {
    
    let projectName: String
    let rate: Double?
    let rateType: RateType?
    let clientId: Int
    var relativeURL: URL? { URL(string: "projects") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        var body: [String: Any] = [
            "projectName": projectName,
            "clientId": clientId,
            "status": ProjectStatus.active.rawValue
        ]
        if let rate, let rateType {
            body["rate"] = rate
            body["rateType"] = rateType.rawValue
        }
        return body
    }
}

enum RateType: String {
    case hour = "hourly"
    case day = "daily"
    case week = "weekly"
    case month = "monthly"
}

enum ProjectStatus: String {
    case active
}
