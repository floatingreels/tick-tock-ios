//
//  GetProjectsResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

struct GetProjectsResponse: Codable {
    let projects: [Project]
}

struct Project: Codable, Identifiable {
    
    let id: Int
    let clientId: Int
    let name: String
    let rate: Double?
    private let rateTypeString: String?
    private let statusString: String
    
    enum CodingKeys: String, CodingKey {
        case id = "projectId"
        case name = "projectName"
        case rate
        case clientId
        case rateTypeString = "rateType"
        case statusString = "status"
    }
    
    var rateType: RateType? {
        guard let rateTypeString,
              let type = RateType.init(rawValue: rateTypeString)
        else { return nil }
        return type
    }
}
