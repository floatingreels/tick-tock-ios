//
//  RequestManager.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Alamofire
import Foundation

final class RequestManager {
    
    static let shared = RequestManager()
    private let service = BackendService()

    private init() {}
    
    func performUserRegistration(firstName: String, lastName: String, email: String, password: String, completion: @escaping @Sendable (Result<LoginResponse, APIErrorResponse>) -> Void) {
        let request = UserRegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        service.execute(request: request, completion: completion)
    }
    
    func performUserLogin(email: String, password: String, completion: @escaping @Sendable (Result<LoginResponse, APIErrorResponse>) -> Void) {
        let request = UserLoginRequest(email: email, password: password)
        service.execute(request: request, completion: completion)
    }
    
    func getClients(completion: @escaping @Sendable (Result<GetClientsResponse, APIErrorResponse>) -> Void) {
        let request = GetClienstRequest()
        service.execute(request: request, completion: completion)
    }
    
    func addClient(companyName: String, completion: @escaping @Sendable (Result<AddClientResponse, APIErrorResponse>) -> Void) {
        let request = AddClientRequest(companyName: companyName)
        service.execute(request: request, completion: completion)
    }
    
    func getClientDetail(clientId: Int, completion: @escaping @Sendable (Result<ClientDetailResponse, APIErrorResponse>) -> Void) {
        let request = ClientDetailRequest(clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func updateClientDetail(clientId: Int, companyName: String?, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = UpdateClientRequest(clientId: clientId, companyName: companyName)
        service.execute(request: request, completion: completion)
    }
    
    func deleteClient(clientId: Int, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = DeleteClientRequest(clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func getProjects(clientId: Int?, completion: @escaping @Sendable (Result<GetProjectsResponse, APIErrorResponse>) -> Void) {
        let request = GetProjectsRequest(clientId: clientId)
        service.execute(request: request, completion: completion)
    }
    
    func addProject(clientId: Int, projectName: String, rate: Double, rateType: RateType, completion: @escaping @Sendable (Result<AddProjectResponse, APIErrorResponse>) -> Void) {
        let request = AddProjectRequest(clientId: clientId, projectName: projectName, rate: rate, rateType: rateType)
        service.execute(request: request, completion: completion)
    }
    
    func getProjectDetail(projectId: Int, completion: @escaping @Sendable (Result<ProjectDetailResponse, APIErrorResponse>) -> Void) {
        let request = ProjectDetailRequest(projectId: projectId)
        service.execute(request: request, completion: completion)
    }
    
    func updateProjectDetail(clientId: Int, projectId: Int, projectName: String?, rate: Double?, rateType: RateType?, status: ProjectStatus?, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = UpdateProjectRequest(clientId: clientId, projectId: projectId, projectName: projectName, rate: rate, rateType: rateType, status: status)
        service.execute(request: request, completion: completion)
    }
    
    func deleteProject(clientId: Int, projectId: Int, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = DeleteProjectRequest(clientId: clientId, projectId: projectId)
        service.execute(request: request, completion: completion)
    }
    
    func getSessions(clientId: Int, projectId: Int, completion: @escaping @Sendable (Result<GetSessionsResponse, APIErrorResponse>) -> Void) {
        let request = GetSessionsRequest(clientId: clientId, projectId: projectId)
        service.execute(request: request, completion: completion)
    }
    
    func addSession(clientId: Int, projectId: Int, start: Date, end: Date, completion: @escaping @Sendable (Result<AddSessionResponse, APIErrorResponse>) -> Void) {
        let request = AddSessionRequest(clientId: clientId, projectId: projectId, start: start, end: end)
        service.execute(request: request, completion: completion)
    }
    
    func getSessionDetail(clientId: Int, projectId: Int, sessionId: Int, completion: @escaping @Sendable (Result<SessionDetailResponse, APIErrorResponse>) -> Void) {
        let request = SessionDetailRequest(clientId: clientId, projectId: projectId, sessionId: sessionId)
        service.execute(request: request, completion: completion)
    }
    
    func updateSessionDetail(clientId: Int, projectId: Int, sessionId: Int, start: Date?, end: Date?, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = UpdateSessionRequest(clientId: clientId, projectId: projectId, sessionId: sessionId, start: start, end: end)
        service.execute(request: request, completion: completion)
    }
    
    func deleteSession(clientId: Int, projectId: Int, sessionId: Int, completion: @escaping @Sendable (Result<EmptyResponse, APIErrorResponse>) -> Void) {
        let request = DeleteSessionRequest(clientId: clientId, projectId: projectId, sessionId: sessionId)
        service.execute(request: request, completion: completion)
    }
}
