//
//  ClientStore.swift
//  TickTock
//
//  Created by David Gunzburg on 20/06/2025.
//

import SwiftUI
import Alamofire

@Observable
final class ClientStore {
    
    var client: Client?
    var clients: [Client] = []
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func addClient(companyName: String, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.addClient(companyName: companyName) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success:
                getAllClients(completion: { _ in })
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func getAllClients(silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getClients { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.clients = response.clients
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func getClientDetail(clientId: Int, silentFailure: Bool = false, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.getClientDetail(clientId: clientId) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success(let response):
                self.client = response.client
                completion(nil)
            case .failure(let error):
                completion(silentFailure ? nil : CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func updateClientDetail(clientId: Int, companyName: String?, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.updateClientDetail(clientId: clientId, companyName: companyName) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success:
                getClientDetail(clientId: clientId, completion: { _ in })
                getAllClients(completion: { _ in })
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func deleteClient(clientId: Int, completion: @escaping (CustomAlert?) -> Void) {
        requestManager.deleteClient(clientId: clientId) { [weak self] data in
            guard let self else { return }
            switch data.result {
            case .success:
                getAllClients(completion: { _ in })
                completion(nil)
            case .failure(let error):
                completion(CustomAlert.serviceError(error, code: data.response?.statusCode))
            }
        }
    }
    
    func resetClientDetail() {
        client = nil
    }
    
    func resetClientsList() {
        clients.removeAll(keepingCapacity: true)
    }
    
    func resetAll() {
        resetClientDetail()
        resetClientsList()
    }
}

extension ClientStore {
    
    static func buildTestClients() -> [Client] {
        let projects = ProjectStore.buildTestProjects()
        return [
            Client(id: 1, name: "Client Tell", projects: projects.filter { $0.clientId == 1 }),
            Client(id: 2, name: "Covert Government Agency", projects: projects.filter { $0.clientId == 3 }),
            Client(id: 3, name: "Sibling Rivalry", projects: projects.filter { $0.clientId == 3 }),
            Client(id: 4, name: "Butsel nv", projects: projects.filter { $0.clientId == 4 }),
            Client(id: 5, name: "ACME Corp", projects: projects.filter { $0.clientId == 5 }),
        ]
    }
}
