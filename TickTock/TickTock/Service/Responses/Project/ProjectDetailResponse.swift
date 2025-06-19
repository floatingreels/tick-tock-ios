//
//  ProjectDetailResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

struct ProjectDetailResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let project: Project
}
