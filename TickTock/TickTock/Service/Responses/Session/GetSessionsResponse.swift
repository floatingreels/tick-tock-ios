//
//  GetSessionsResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

struct GetSessionsResponse: Respondable, Codable {
    let success: Bool
    let message: String?
    let sessions: [Session]
}
