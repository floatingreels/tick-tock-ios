//
//  SessionStore.swift
//  TickTock
//
//  Created by David Gunzburg on 20/06/2025.
//

import SwiftUI
import Alamofire

@Observable
final class SessionStore {
    
    var session: Session? = nil
    var sessions: [Session] = []
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getSessions(clientId: Int, projectId: Int, silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getSessions(clientId: clientId, projectId: projectId) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.sessions = response.sessions
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func getSessionDetail(clientId: Int, projectId: Int, sessionId: Int, silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getSessionDetail(clientId: clientId, projectId: projectId, sessionId: sessionId) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.session = response.session
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func updateSessionDetail(clientId: Int, projectId: Int, sessionId: Int, start: Date?, end: Date?, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        requestManager.updateSessionDetail(clientId: clientId, projectId: projectId, sessionId: sessionId, start: start, end: end, completion: completion)
    }
    
    func deleteSession(clientId: Int, projectId: Int, sessionId: Int, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        requestManager.deleteSession(clientId: clientId, projectId: projectId, sessionId: sessionId, completion: completion)
    }
}

extension SessionStore {
    
    static func buildTestSessions() -> [Session] {
        let clients = ClientStore.buildTestClients()
        let projects = ProjectStore.buildTestProjects()
        var sessions: [Session] = []
        projects.forEach { p in
            sessions.append(Session(
                id: 100 * p.id + 1,
                projectId: p.id,
                projectName: p.name,
                clientName: clients.first(where: { $0.id == p.clientId ?? 0 })?.name ?? "Mystery Customer",
                startedAt: "2024-06-30T22:23:46Z",
                endedAt: "2024-07-01T00:01:46Z"
            ))
            sessions.append(Session(
                id: 100 * p.id + 2,
                projectId: p.id,
                projectName: p.name,
                clientName: clients.first(where: { $0.id == p.clientId ?? 0 })?.name ?? "Mystery Customer",
                startedAt: "2025-05-30T12:00:46Z",
                endedAt: "2025-05-30T16:06:46Z"
            ))
            sessions.append(Session(
                id: 100 * p.id + 3,
                projectId: p.id,
                projectName: p.name,
                clientName: clients.first(where: { $0.id == p.clientId ?? 0 })?.name ?? "Mystery Customer",
                startedAt: "2025-02-22T12:23:46Z",
                endedAt: "2025-02-22T18:01:46Z"
            ))
            sessions.append(Session(
                id: 100 * p.id + 4,
                projectId: p.id,
                projectName: p.name,
                clientName: clients.first(where: { $0.id == p.clientId ?? 0 })?.name ?? "Mystery Customer",
                startedAt: "2025-06-11T08:00:46Z",
                endedAt: "2025-06-11T12:31:46Z"
            ))
            sessions.append(Session(
                id: 100 * p.id + 5,
                projectId: p.id,
                projectName: p.name,
                clientName: clients.first(where: { $0.id == p.clientId ?? 0 })?.name ?? "Mystery Customer",
                startedAt: "2023-06-11T13:13:46Z",
                endedAt: "2023-06-11T18:31:46Z"
            ))
        }
        return sessions
    }
}
