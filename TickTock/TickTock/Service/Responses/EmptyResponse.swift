//
//  EmptyResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 28/05/2025.
//

struct EmptyResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
}
