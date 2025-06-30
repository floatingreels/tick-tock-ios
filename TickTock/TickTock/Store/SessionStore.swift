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
    
    var sessionId: Int = 0
    var sessions: [Session] = []
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getSessions(clientId: Int, projectId: Int, completion: @escaping @Sendable (AFDataResponse<GetSessionsResponse>) -> Void) {
        requestManager.getSessions(clientId: clientId, projectId: projectId, completion:  completion)
    }
    
    func addSession(clientId: Int, projectId: Int, start: Date?, end: Date?, completion: @escaping @Sendable (AFDataResponse<AddSessionResponse>) -> Void) {
        requestManager.addSession(clientId: clientId, projectId: projectId, start: start, end: end, completion: completion)
    }
    
    func getSessionDetail(clientId: Int, projectId: Int, sessionId: Int, completion: @escaping @Sendable (AFDataResponse<SessionDetailResponse>) -> Void) {
        requestManager.getSessionDetail(clientId: clientId, projectId: projectId, sessionId: sessionId, completion: completion)
    }
    
    func updateSessionDetail(clientId: Int, projectId: Int, sessionId: Int, start: Date?, end: Date?, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        requestManager.updateSessionDetail(clientId: clientId, projectId: projectId, sessionId: sessionId, start: start, end: end, completion: completion)
    }
    
    func deleteSession(clientId: Int, projectId: Int, sessionId: Int, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        requestManager.deleteSession(clientId: clientId, projectId: projectId, sessionId: sessionId, completion: completion)
    }
}
