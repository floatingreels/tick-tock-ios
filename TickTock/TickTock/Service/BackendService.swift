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
    private let authHeaderTuple = ("Authorization", "Bearer ")
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
                print("Request failed to build")
                return
            }
            AF.request(request)
                .responseDecodable(of: responseType) { response in
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("RESPONSE\nResponse body: \(utf8Text)")
                    }
                    print("Response code: \(response.response?.statusCode ?? 666)\n")
                    switch response.result {
                    case .success(let result):
                        if let result = result as? EmptyResponse {
                            if result.success {
                                print("SUCCESS: \(result.message)\n")
                            } else {
                                print("FAILURE: \(result.message)\n")
                            }
                        }
                    case .failure(let error):
                        print("Failed with errorcode \(error.responseCode ?? 666): \(error.localizedDescription)\n")
                    }
                    completion(response)
                }
        } catch {
            print("Request failed to build")
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
                print(buildSuccessLog(request: request, url: newURL, urlRequest: urlRequest, bodyData: data))
            } catch {
                print("JSON serialization failed")
            }
        } else {
            print(buildSuccessLog(request: request, url: newURL, urlRequest: urlRequest))
        }
        return urlRequest
    }
    
    private func buildSuccessLog(request: Requestable, url: URL, urlRequest: URLRequest, bodyData: Data? = nil) -> String {
        var log = "REQUEST\n"
        log += "Request URL: \(url.absoluteString)\n"
        log += "Request headers:\n"
        if let content = urlRequest.value(forHTTPHeaderField: contentHeaderTuple.0) {
            log += "    \(contentHeaderTuple.0) = \(content)\n"
        }
        if let auth = urlRequest.value(forHTTPHeaderField: authHeaderTuple.0) {
            log += "    \(authHeaderTuple.0) = \(authHeaderTuple.1)\(auth)\n"
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
        return log
    }
}
