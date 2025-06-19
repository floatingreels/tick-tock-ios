//
//  SessionDetailResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

struct SessionDetailResponse: Respondable, Codable {
    
    let success: Bool
    let message: String?
    let session: Session
}

struct Session: Codable {
    let id: Int
    let projectId: Int
    let projectName: String
    let clientName: String
    private let startedAt: String?
    private let endedAt: String?
    let duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "sessionId"
        case projectId
        case projectName
        case clientName
        case startedAt
        case endedAt
        case duration        
    }
    
    var start: Date? {
        guard let startedAt else { return nil }
        return ISODateFormatter.shared.dateFromISOString(startedAt)
    }
    var end: Date? {
        guard let endedAt else { return nil }
        return ISODateFormatter.shared.dateFromISOString(endedAt)
    }
  }
