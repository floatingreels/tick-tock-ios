//
//  RequestManager.swift
//  TickTock
//
//  Created by David Gunzburg on 22/05/2025.
//

import Foundation
import Alamofire

final class RequestManager {
    
    static let shared = RequestManager()
    private let service = BackendService()
    
    func getClients(completion: @escaping @Sendable (AFDataResponse<GetClientsResponse>) -> Void) {
        let request = GetClienstRequest()
        service.execute(request: request, completion: completion)
    }
    
    func addClient(companyName: String, completion: @escaping @Sendable (AFDataResponse<AddClientResponse>) -> Void) {
        let request = AddClientRequest(companyName: companyName)
        service.execute(request: request, completion: completion)
    }
    
    func getClientDetail(clientId: Int, completion: @escaping @Sendable (AFDataResponse<ClientDetailResponse>) -> Void) {
        let request = ClientDetailRequest(clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func updateClientDetail(clientId: Int, companyName: String?, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = UpdateClientRequest(clientId: clientId, companyName: companyName)
        service.execute(request: request, completion: completion)
    }
    
    func deleteClient(clientId: Int, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = DeleteClientRequest(clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func getProjects(completion: @escaping @Sendable (AFDataResponse<GetProjectsResponse>) -> Void) {
        let request = GetProjectsRequest()
        service.execute(request: request, completion: completion)
    }
    
    func addProject(projectName: String, clientId: Int, rate: Double? = nil, rateType: RateType? = nil, completion: @escaping @Sendable (AFDataResponse<AddProjectResponse>) -> Void) {
        let request = AddProjectRequest(projectName: projectName, rate: rate, rateType: rateType, clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func getProjectDetail(projectId: Int, completion: @escaping @Sendable (AFDataResponse<ProjectDetailResponse>) -> Void) {
        let request = ProjectDetailRequest(projectId: projectId)
        service.execute(request: request, completion: completion)
    }
    
    func updateProjectDetail(projectId: Int, projectName: String?, rate: Double?, rateType: RateType?, status: ProjectStatus?, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = UpdateProjectRequest(projectId: projectId, projectName: projectName, rate: rate, rateType: rateType, status: status)
        service.execute(request: request, completion: completion)
    }
    
    func deleteProject(projectId: Int, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = DeleteProjectRequest(projectId: projectId)
        service.execute(request: request, completion: completion)
    }
    
    func getSessions(completion: @escaping @Sendable (AFDataResponse<GetSessionsResponse>) -> Void) {
        let request = GetProjectsRequest()
        service.execute(request: request, completion: completion)
    }
    
    func addSesion(projectId: String, start: Date?, end: Date?, completion: @escaping @Sendable (AFDataResponse<AddSessionResponse>) -> Void) {
        let request = AddSessionRequest(projectId: projectId, start: start, end: end)
        service.execute(request: request, completion: completion)
    }
    
    func getSessionDetail(sessionId: Int, completion: @escaping @Sendable (AFDataResponse<SessionDetailResponse>) -> Void) {
        let request = SessionDetailRequest(sessionId: sessionId)
        service.execute(request: request, completion: completion)
    }
    
    func updateSessionDetail(sessionId: Int, start: Date?, end: Date?, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = UpdateSessionRequest(sessionId: sessionId, start: start, end: end)
        service.execute(request: request, completion: completion)
    }
    
    func deleteSession(sessionId: Int, completion: @escaping @Sendable (AFDataResponse<EmptyResponse>) -> Void) {
        let request = DeleteSessionRequest(sessionId: sessionId)
        service.execute(request: request, completion: completion)
    }
}
