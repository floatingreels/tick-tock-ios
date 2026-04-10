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

struct Client: Codable {
    
    let id: Int
    let name: String
    let projects: [Project]?
    let userId: Int
    
    init(id: Int, name: String, projects: [Project]?) {
        self.id = id
        self.name = name
        self.projects = projects
        self.userId = TickTockDefaults.shared.userId
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "clientId"
        case name = "companyName"
        case projects
        case userId
    }
    
    func toSelectable() -> ClientCellData {
        ClientCellData(id: id, title: name)
    }
}

struct ClientCellData: Selectable, Hashable {
    let id: Int
    let title: String
    var subtitle: String? = nil
}
