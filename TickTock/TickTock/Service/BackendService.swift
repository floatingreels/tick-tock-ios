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
    case head = "HEAD"
    case post = "POST"
    case put = "PATCH"
    case patch = "PUT"
    case delete = "DELETE"
}

typealias RequestQuery = [String: String]
typealias RequestBody = [String: Any]

class ServiceManager {
    
    static let shared = ServiceManager()
    
    private let baseURL: URL? = URL(string: "https://jiypepwmdk.eu-west-1.awsapprunner.com/api")
    
//    private lazy var request: URLRequest? = {
//        guard let baseURL else { return nil }
//        return URLRequest(url: baseURL)
//    }()
    
    func buildRequest(_ request: Requestable) throws -> URLRequest? {
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
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        // add body to the request in json format
        if let body = request.body {
            do {
                let data =  try JSONSerialization.data(withJSONObject: body, options: [])
                urlRequest.httpBody = data
                print("REQUEST:\nRequest URL = \(newURL.absoluteString)\nRequest method = \(request.method.rawValue)\nRequest body = \(String(data: data, encoding: .utf8) ?? "No data")")
            } catch {
                print("JSON serialization failed")
            }
        } else {
            print("REQUEST:\nRequest URL = \(newURL.absoluteString)\nRequest method = \(request.method.rawValue)\nRequest body = none")
        }
        return urlRequest
    }
}
