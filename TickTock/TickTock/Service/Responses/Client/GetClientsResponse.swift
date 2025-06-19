//
//  GetClientsResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//


struct GetClientsResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let clients: [Client]
}

struct Client: Codable, Selectable, Hashable {
    
    static let testClientId = 2
    
    let id: Int
    let name: String
    let projects: [Project]?
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "clientId"
        case name = "companyName"
        case projects
        case userId
    }
    
    static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.id == rhs.id
    }
}
