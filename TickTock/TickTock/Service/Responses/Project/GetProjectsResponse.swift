//
//  GetProjectsResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

struct GetProjectsResponse: Respondable, Codable {
    let success: Bool
    let message: String?
    let projects: [Project]
}

struct Project: Codable, Selectable, Hashable {
    
    let id: Int
    let clientId: Int?
    let name: String
    let rate: Double?
    private let rateTypeString: String?
    private let statusString: String?
    
    init(id: Int, clientId: Int, name: String, rate: Double?, rateTypeString: String?, statusString: String) {
        self.id = id
        self.clientId = clientId
        self.name = name
        self.rate = rate
        self.rateTypeString = rateTypeString
        self.statusString = statusString
    }
    
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
