//
//  ClientDetailResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

struct ClientDetailResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let client: Client
}
