//
//  StoreManager.swift
//  TickTock
//
//  Created by David Gunzburg on 20/06/2025.
//

import SwiftUI

@Observable
final class StoreManager {
    
    let authStore: AuthStore
    let clientStore: ClientStore
    let projectStore: ProjectStore
    let sessionStore: SessionStore
    let requestManager: RequestManager
    
    init(requestManager: RequestManager = RequestManager.shared) {
        self.requestManager = requestManager
        self.authStore = AuthStore(requestManager: requestManager)
        self.clientStore = ClientStore(requestManager: requestManager)
        self.projectStore = ProjectStore(requestManager: requestManager)
        self.sessionStore = SessionStore(requestManager: requestManager)
    }
    
    func addProject(clientId: Int, projectName: String, rate: Double, rateType: RateType, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.addProject(clientId: clientId, projectName: projectName, rate: rate, rateType: rateType) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.refreshProjects()
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error))
            }
        }
    }
    
    func updateProjectDetail(clientId: Int, projectId: Int, projectName: String?, rate: Double?, rateType: RateType?, status: ProjectStatus?, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.updateProjectDetail(clientId: clientId, projectId: projectId, projectName: projectName, rate: rate, rateType: rateType, status: status) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.projectStore.getProjectDetail(projectId: projectId, silentFailure: true, completion: { _ in })
                refreshProjects()
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error))
            }
        }
    }
    
    func deleteProject(clientId: Int, projectId: Int, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.deleteProject(clientId: clientId, projectId: projectId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.refreshProjects()
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error))
            }
        }
    }
    
    func createSession(startDate: Date, endDate: Date, completion: @escaping (CustomAlert?) -> Void) {
        guard let project = projectStore.project,
              let clientId = project.clientId
        else {
            completion(CustomAlert.generalError())
            return
        }
        requestManager.addSession(clientId: clientId, projectId: project.id, start: startDate, end: endDate) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.refreshProjects()
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error))
            }
            
        }
    }
    
    private func refreshProjects() {
        if let clientId = clientStore.client?.id { // project was added/modified/deleted from Client Detail screen
            self.clientStore.getClientDetail(clientId: clientId, silentFailure: true, completion: { _ in } )
        } else { // project was added from Projects List screen
            self.projectStore.getAllProjects(silentFailure: true, completion: { _ in })
        }
    }
}
