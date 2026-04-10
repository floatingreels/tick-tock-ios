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
    var startedAt: String?
    var endedAt: String?
    
    init(id: Int, projectId: Int, projectName: String, clientName: String, startedAt: String?, endedAt: String?) {
        self.id = id
        self.projectId = projectId
        self.projectName = projectName
        self.clientName = clientName
        self.startedAt = startedAt
        self.endedAt = endedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "sessionId"
        case projectId
        case projectName
        case clientName
        case startedAt
        case endedAt
    }
    
    func toSelectable() -> SessionCellData {
        var date = ""
        if let start {
            date = DateTimeUtil.shared.formattedStringFromDate(start)
        }
        return SessionCellData(id: id, title: date, subtitle: duration)
    }
    
    private var start: Date? {
        guard let startedAt else { return nil }
        return DateTimeUtil.shared.dateFromISOString(startedAt)
    }
    
    private var end: Date? {
        guard let endedAt else { return nil }
        return DateTimeUtil.shared.dateFromISOString(endedAt)
    }
    
    private var duration: String {
        guard let startedAt, let endedAt else { return "" }
        return DateTimeUtil.shared.formattedDurationFromISO(start: startedAt, end: endedAt) ?? ""
    }
}

struct SessionCellData: Selectable, Hashable {
    let id: Int
    let title: String
    var subtitle: String?
}
