//
//  AddClientResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 30/05/2025.
//

 struct AddClientResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let clientId: Int
}
