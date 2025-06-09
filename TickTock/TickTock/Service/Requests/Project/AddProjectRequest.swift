//
//  AddProjectRequest.swift
//  TickTock
//
//  Created by David Gunzburg on 01/06/2025.
//

import Foundation

struct AddProjectRequest: Requestable {
    
    let clientId: Int
    let projectName: String
    let rate: Double
    let rateType: RateType
    
    var relativeURL: URL? { URL(string: "users/\(TickTockDefaults.shared.userId)/clients/\(clientId)/projects") }
    var method: RequestMethod { .post }
    var query: RequestQuery? { nil }
    var body: RequestBody? {
        return [
            "projectName": projectName,
            "status": ProjectStatus.active.rawValue,
            "rate": rate,
            "rateType": rateType.rawValue
        ]
    }
}

enum RateType: String, CaseIterable, Identifiable {
    case hour = "hour"
    case day = "day"
    case week = "week"
    case month = "month"
    
    var id: RateType { self }
    
    var name: String {
        switch self {
        case .hour: Translation.Project.projectRateTypeHour.val
        case .day: Translation.Project.projectRateTypeDay.val
        case .week: Translation.Project.projectRateTypeWeek.val
        case .month: Translation.Project.projectRateTypeMonth.val
        }
    }
}

enum ProjectStatus: String {
    case active
}
