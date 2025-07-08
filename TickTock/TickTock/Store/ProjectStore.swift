//
//  ProjectStore.swift
//  TickTock
//
//  Created by David Gunzburg on 20/06/2025.
//

import SwiftUI
import Alamofire

@Observable
final class ProjectStore {
    
    var project: Project? = nil
    var projects: [Project] = []
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getAllProjects(silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getProjects(clientId: nil) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.projects = response.projects
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func getProjectDetail(projectId: Int, silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getProjectDetail(projectId: projectId) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.project = response.project
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func resetProjectDetail() {
        project = nil
    }
    
    func resetProjectsList() {
        projects.removeAll(keepingCapacity: true)
    }
    
    func resetAll() {
        resetProjectDetail()
        resetProjectsList()
    }
}


extension ProjectStore {
    
    static func buildTestProjects() -> [Project] {
        [
            Project(id: 1, clientId: 1, name: "Translation \"Arctica\"", rate: 1800, rateTypeString: "week", statusString: "active"),
            Project(id: 2, clientId: 1, name: "Dossier Europe \"Arctica\"", rate: 31.2, rateTypeString: "hour", statusString: "active"),
            Project(id: 3, clientId: 2, name: "Manhattan Project", rate: 4771, rateTypeString: "month", statusString: "active"),
            Project(id: 4, clientId: 3, name: "Unnamed FinTech app", rate: 66.6, rateTypeString: "hour", statusString: "active"),
            Project(id: 5, clientId: 3, name: "TickTock", rate: 66.6, rateTypeString: "hour", statusString: "active"),
            Project(id: 6, clientId: 3, name: "MicroServices", rate: 66.6, rateTypeString: "hour", statusString: "active"),
            Project(id: 7, clientId: 4, name: "P.R.O.J.E.C.T", rate: 420, rateTypeString: "day", statusString: "active"),
            Project(id: 8, clientId: 5, name: "Reject", rate: 2250, rateTypeString: "week", statusString: "active"),
            Project(id: 9, clientId: 5, name: "Anonymous", rate: 420, rateTypeString: "day", statusString: "active"),
            Project(id: 10, clientId: 5, name: "The Jects", rate: 2250, rateTypeString: "week", statusString: "active")
        ]
    }
}
