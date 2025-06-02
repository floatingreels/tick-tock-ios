//
//  GetClientsResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//


struct GetClientsResponse: Codable {
    
    let clients: [Client]
}

struct Client: Codable {
    
    let id: Int
    let name: String
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "clientId"
        case name = "companyName"
        case userId = "userId"
    }
}
