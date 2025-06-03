//
//  ServiceManager.swift
//  TickTock
//
//  Created by David Gunzburg on 21/05/2025.
//
import Foundation
import Alamofire

protocol Requestable {
    var relativeURL: URL? { get }
    var method: RequestMethod { get }
    var query: RequestQuery? { get }
    var body: RequestBody? { get }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias RequestQuery = [String: String]
typealias RequestBody = [String: Any]

final class BackendService {
    
    static let shared = BackendService()
    
    private let baseURL: URL? = URL(string: "https://jiypepwmdk.eu-west-1.awsapprunner.com/api")
    private let authHeaderTuple = ("Authorization", "Bearer")
    private let ajaxHeaderTuple = ("X-Requested-With", "XMLHttpRequest")
    private let contentHeaderTuple = ("Content-Type", "application/json")
    
    func execute<T>(
        request: Requestable,
        responseType: T.Type = T.self,
        completion: @escaping @Sendable (AFDataResponse<T>) -> Void
    ) where T: Codable, T: Sendable {
        do {
            guard let request = try buildRequest(request)
            else {
                logRequestFailure()
                return
            }
            AF.request(request)
                .responseDecodable(of: responseType) { [weak self] response in
                    guard let self else { return }
                    switch response.result {
                    case .success(_):
                        logResponseSuccess(code: response.response?.statusCode, bodyData: response.data)
                    case .failure(let error):
                       logResponseFailure(error)
                    }
                    completion(response)
                }
        } catch {
            logRequestFailure()
        }
    }
    
    private func buildRequest(_ request: Requestable) throws -> URLRequest? {
        guard
            let baseURL,
            let relativeURL = request.relativeURL,
            let components = URLComponents(url: relativeURL, resolvingAgainstBaseURL: false)
        else { return nil }
        // append all components of relative url to the base url
        var newURL = baseURL.appendingPathComponent(components.path)
        guard var newComponents = URLComponents(url: newURL, resolvingAgainstBaseURL: false) else { return nil }
        // append any hardcoded query paramters to the new url
        newComponents.queryItems = components.queryItems
        newURL = newComponents.url ?? newURL
        // append additional queries to the new url
        if let query = request.query {
            let queryItems: [URLQueryItem] = query.map { URLQueryItem(name: $0.key, value: $0.value) }
            if newComponents.queryItems == nil {
                newComponents.queryItems = queryItems
            } else {
                newComponents.queryItems?.append(contentsOf: queryItems)
            }
        }
        // create a request based on the new url
        var urlRequest = URLRequest(url: newURL)
        // set the http method for the request
        urlRequest.httpMethod = request.method.rawValue
        // add headers to the request
        urlRequest.setValue(contentHeaderTuple.1, forHTTPHeaderField: contentHeaderTuple.0)
        if let accesToken = BackendCredentials.shared.getAccessToken() {
            urlRequest.addValue(ajaxHeaderTuple.1, forHTTPHeaderField: ajaxHeaderTuple.0)
            urlRequest.addValue("\(authHeaderTuple.1)\(accesToken)", forHTTPHeaderField: authHeaderTuple.0)
        }
        // add body to the request in json format
        if let body = request.body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: [])
                urlRequest.httpBody = data
                logRequestSuccess(request: request, url: newURL, urlRequest: urlRequest, bodyData: data)
            } catch {
                print("ERROR\nError message: JSON serialization failed")
            }
        } else {
            logRequestSuccess(request: request, url: newURL, urlRequest: urlRequest)
        }
        return urlRequest
    }
    
    private func logRequestFailure() {
        print("ERROR\nError message: request failed to build")
    }
    
    private func logRequestSuccess(request: Requestable, url: URL, urlRequest: URLRequest, bodyData: Data? = nil) {
        var log = "REQUEST\n"
        log += "Request URL: \(url.absoluteString)\n"
        log += "Request headers:\n"
        if let content = urlRequest.value(forHTTPHeaderField: contentHeaderTuple.0) {
            log += "    \(contentHeaderTuple.0) = \(content)\n"
        }
        if let auth = urlRequest.value(forHTTPHeaderField: authHeaderTuple.0) {
            log += "    \(authHeaderTuple.0) = \(authHeaderTuple.1) \(auth)\n"
        }
        if let ajax = urlRequest.value(forHTTPHeaderField: ajaxHeaderTuple.0) {
            log += "    \(ajaxHeaderTuple.0) = \(ajax)\n"
        }
        log += "Request method: \(request.method.rawValue)\n"
        log += "Request body: "
        if let bodyData {
            log += "\(String(data: bodyData, encoding: .utf8) ?? "No data")"
        } else {
            log += "none"
        }
        print(log)
    }
    
    private func logResponseFailure(_ error: AFError) {
        var log = "ERROR\n"
        log += "Error code: \(error.responseCode ?? 666)"
        log += "Error message: \(error.localizedDescription)"
        print()
    }
    
    private func logResponseSuccess(code: Int?, bodyData: Data?) {
        var log = "RESPONSE\n"
        if let code {
            log += "Response code: \(code)"
        }
        if let bodyData, let bodyString = String(data: bodyData, encoding: .utf8)  {
            log += "Response body: \(bodyString)"
        }
        print(log)
    }
}
