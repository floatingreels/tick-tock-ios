//
//  UpdateProjectRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct UpdateProjectRequest: Requestable {
    
    let clientId: Int
    let projectId: Int
    let projectName: String?
    let rate: Double?
    let rateType: RateType?
    let status: ProjectStatus?
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects/\(projectId)") }
    var method: RequestMethod { .put }
    var query: RequestQuery? = nil
    var body: RequestBody? {
        var body = [String: Any]()
        if let projectName {
            body["projectName"] = projectName
        }
        if let rate {
            body["rate"] = rate
        }
        if let rateType {
            body["rateType"] = rateType
        }
        if let status {
            body["status"] = status
        }
        return body
    }
}
