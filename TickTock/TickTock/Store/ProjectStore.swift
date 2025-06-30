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
