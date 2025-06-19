//
//  AddProjectResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

struct AddProjectResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?    
    let projectId: Int
}
