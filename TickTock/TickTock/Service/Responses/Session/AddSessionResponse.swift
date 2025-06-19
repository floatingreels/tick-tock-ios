//
//  AddSessionResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//


struct AddSessionResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let sessionId: Int
}
